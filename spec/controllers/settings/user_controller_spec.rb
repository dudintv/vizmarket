require 'rails_helper'

RSpec.describe Settings::UserController, type: :controller do

  describe 'GET #index' do
    def make_request
      get :index
    end

    it_behaves_like 'Authorizable with redirect to login'
  end

  describe 'GET #show' do
    def make_request
      get :show, format: :json
    end

    it_behaves_like 'Authorizable with json'
  end

  describe 'POST #update' do
    let(:user) { create :user }
    let(:avatar) { fixture_file_upload('spec/fixtures/images/1920x1080_leopard.jpg', 'image/jpeg') }

    def make_request
      post :update, params: { user: {
        name: '123',
        surname: '123',
        jobtitle: '123',
        country: '123',
        about: '123',
        avatar: avatar
        } }, format: :json
    end

    it_behaves_like 'Authorizable with json'

    context 'Authenticated user' do
      before do
        sign_in user
      end

      it 'updates user data' do
        expect {
          make_request
          user.reload
        }.to change { user.name }
        .and change { user.surname}
        .and change { user.jobtitle}
        .and change { user.country}
        .and change { user.about}
        .and change { user.avatar.attached? }.to true
      end
    end
  end

  describe 'POST #update_password' do
    let(:current_password) { 'qwerty' }
    let(:new_password) { current_password + '_new' }
    let(:user) { create :user, password: current_password, password_confirmation: current_password }

    def make_request(params = {})
      post :update_password, params: { user: {
        current_password: current_password, new_password: new_password
      }}.merge(params), format: :json
    end
    
    it_behaves_like 'Authorizable with json'

    context 'Authenticated user' do
      before do
        sign_in user
      end

      it 'updates user password' do
        expect {
          make_request
          user.reload
        }.to change { user.valid_password?(current_password) }.to(false)
        .and change { user.valid_password?(new_password)     }.to(true)
      end
  
      context 'with wrong current password' do
        it 'returns http unauthorized' do
          make_request({user: { current_password: current_password + '_wrong' }})
          expect(response).to have_http_status(:unauthorized)
        end
        
        it 'doesn\'t update user password' do
          expect {
            make_request({user: { current_password: current_password + '_wrong' }})
            user.reload
          }.to_not change { user.password }
        end
      end
    end
  end

  describe 'POST #reset_password' do
    let(:user) { create :user }

    def make_request
      post :reset_password, format: :json
    end

    context 'Authorized user' do
      before do
        sign_in user
      end

      it 'start password resetting process' do
        expect{
          make_request
          user.reload
        }.to change { user.reset_password_sent_at }.from(nil)
        .and change { user.reset_password_token }.from(nil)
      end
    end
  end

  describe 'DELETE #destroy_account_link' do
    let(:user) { create :user_with_oauth }

    def make_request
      delete :destroy_account_link, params: { link: 'google' }, format: :json
    end

    it_behaves_like 'Authorizable with json'

    context 'Authorized user' do
      before do
        sign_in user
      end

      it 'deletes account link with Google' do
        expect{
          make_request
        }.to change{ user.authorizations.count }.by(-1)
      end
    end
  end

  describe 'DELETE #destroy_my_account' do
    let(:user) { create :user }

    def make_request
      delete :destroy_my_account
    end

    context 'Guest user' do
      it 'returns http unauthorized' do
        make_request
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'Authorized user' do
      before do
        sign_in user
      end

      it 'redirects to root url' do
        make_request
        expect(response).to redirect_to(root_path)
      end

      it 'marks the user as deleted' do
        expect{
          make_request
          user.reload
        }.to change { user.deleted_at }.from(nil)
      end
    end
  end

end
