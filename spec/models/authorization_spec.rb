require 'rails_helper'

RSpec.describe Authorization, type: :model do
  it { should belong_to(:user) }

  describe 'callback :after_create' do
    let(:authorization) { create(:authorization) }

    it 'confirmation_token is set after create' do
      expect(authorization.confirmation_token).not_to be_nil
    end
    it 'confirmation_token have 20 characters or more' do
      expect(authorization.confirmation_token.length).to be >= 20
    end
  end

  describe '#send_confirmation' do
    let!(:unconfirmed_authorization) { create(:authorization) }
    let!(:confirmed_authorization) { create(:authorization, confirmed_at: Time.zone.now) }

    it 'send confirmation email when authorization unconfirmed' do
      expect { unconfirmed_authorization.send_confirmation }.to change { AuthorizationMailer.deliveries.count }.by(1)
    end

    it 'do not send confirmation email when authorization succesfully confirmed' do
      expect { confirmed_authorization.send_confirmation }.not_to change { AuthorizationMailer.deliveries.count }
    end
  end

  describe '#confirm' do
    let(:authorization) { create(:authorization) }

    it 'set confirmed_at to some time' do
      expect(authorization.confirmed_at).to be_nil
      authorization.confirm(authorization.confirmation_token)
      expect(authorization.confirmed_at).not_to be_nil
    end

    it 'return true if token is correct' do
      expect(authorization.confirm(authorization.confirmation_token)).to be true
    end

    it 'return false if token is wrong' do
      expect(authorization.confirm('wrong_token')).to be false
    end    
  end

  describe '.generate' do
    let(:params) { { provider: 'facebook', uid: '123', email: 'generate@email.com' } }

    it 'create authorization if user with the email exist' do
      create(:user, email: params[:email])
      expect(Authorization.generate(params)).to be_a Authorization
    end

    it 'create authorization if user with the email does not exist' do
      expect(Authorization.generate(params)).to be_a Authorization
    end

    it 'return existing authorization if this already exist' do
      user = create(:user, email: params[:email])
      authorization = create(:authorization, provider: params[:provider], uid: params[:uid], user: user)
      expect(Authorization.generate(params)).to eq authorization
    end
  end
end
