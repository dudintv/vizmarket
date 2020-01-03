require 'rails_helper'

shared_examples_for 'Omniauthable' do |provider|
  let(:auth) { OmniAuth.config.mock_auth[provider] }
  let(:user) { create(:user, email: auth.info&.email || 'user@email.com') }
  
  before do
    request.env['devise.mapping'] = Devise.mappings[:user]
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[provider]
  end

  context "with a new #{provider} user" do
    before { get provider }

    it 'redirect to root with email' do
      expect(response).to redirect_to(root_path) if auth.info&.email
    end
    it '200 status without email' do
      expect(response).to be_success unless auth.info&.email
    end
    it 'sign in user' do
      expect(controller.current_user).to eq User.first
    end
  end

  context "with existing and confirmed #{provider} user" do
    before do
      create(:confirmed_authorization, user: user, provider: auth.provider, uid: auth.uid)
      get provider
    end
    
    it { expect(response).to redirect_to(root_path) }
    it 'sign in user' do
      expect(controller.current_user).to eq user
    end
  end
  
  context "with existing but unconfirmed #{provider} user" do
    before do
      create(:authorization, user: user, provider: auth.provider, uid: auth.uid)
      get provider
    end

    # it 'render authorization/unconfirmed' do
    #   expect(response).to render_template('authorization/unconfirmed')
    # end
    it 'not sign in user' do
      expect(controller.current_user).to be_nil
    end
  end
end

RSpec.describe Users::OmniauthCallbacksController, type: :controller do
  let(:user) { create(:user) }

  describe 'Facebook' do
    it_behaves_like 'Omniauthable', :facebook
  end

  describe 'Google' do
    it_behaves_like 'Omniauthable', :google
  end
end
