require 'rails_helper'

RSpec.describe Publisher::AuthorController, type: :controller do

  describe "GET #index" do
    def make_request
      get :index
    end
    
    it_behaves_like 'Authorizable with redirect to login'
  end

  describe "GET #new" do # this is "START"
    def make_request
      get :new
    end
    
    it_behaves_like 'Authorizable with redirect to login'
  end

  describe 'POST #create' do
    let(:user) { create :user }

    def make_request
      post :create, params: { author: { name: user.name, title: user.jobtitle } }, format: :json
    end

    it_behaves_like 'Authorizable with json'

    context 'Authorized user' do
      before do
        sign_in user
      end

      it 'updates publisher status' do
        expect{
          make_request
          user.reload
        }.to change { user.is_author? }.to (true)
      end
    end
  end

  describe 'POST #update' do
    let(:author) { create :author }
    let(:user) { author.user }

    def make_request
      post :update, params: { author: { name: author.name+'_new', title: author.title+'_new' } }, format: :json
    end

    it_behaves_like 'Authorizable with json'

    context 'Authorized user' do
      before do
        sign_in user
      end

      it 'updates publisher status' do
        expect{
          make_request
          author.reload
        }.to change { author.name }
        .and change { author.title }
      end
    end
  end

end
