require 'rails_helper'

RSpec.describe Publisher::Api::ProductsController, type: :controller do

  describe 'GET #index' do
    context 'Guest user' do
      it 'redirects to login' do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'Authenticated user' do
      sign_in_user
      
      it 'returns http success' do
        get :index
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'GET #show' do
    let(:product) { create(:product) }

    context 'Guest user' do
      it 'return unauthorized (401)' do
        get :show, params: { id: product.id }, format: :json
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'Authenticated user' do
      sign_in_user

      context 'With wrong id' do
        it 'return not_found (404)' do
          get :show, params: { id: product.id + 1 }, format: :json
          expect(response).to have_http_status(:not_found)
        end
      end

      context 'With correct id' do
        it 'returns http success' do
          get :show, params: { id: product.id }, format: :json
          expect(response).to have_http_status(:success)
        end
      end
    end
  end

  describe 'POST #create' do
    let(:product_params) { attributes_for(:product) }

    context 'Guest user' do
      let(:product_params_title_and_kind) { { name: product_params[:title], kind: product_params[:kind][:title] } } 

      it 'redirects to login' do
        post :create, params: product_params_title_and_kind, format: :json
        expect(response).to have_http_status(:unauthorized)
      end

      it 'does not save the new product' do
        expect { post :create, params: product_params_title_and_kind, format: :json }.to_not change(Product, :count)
      end
    end

    context 'Authenticated user' do
      sign_in_user
      
      context 'Do not create with only :title, without kind' do
        let(:product_params_title) { { name: product_params[:title] } }
        
        it 'returns http unprocessable_entity' do
          post :create, params: product_params_title, format: :json
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'does not save the new product' do
          expect { post :create, params: product_params_title, format: :json }.to_not change(Product, :count)
        end
      end

      context 'Do not create with empty title' do
        let(:product_params_empty_title) { { name: '', kind: product_params[:kind][:title] } } 
        
        it 'returns http unprocessable_entity' do
          post :create, params: product_params_empty_title, format: :json
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'does not save the new product' do
          expect { post :create, params: product_params_empty_title, format: :json }.to_not change(Product, :count)
        end
      end

      context 'Do not create with wrong kind' do
        let(:product_params_title_and_wrong_kind) { { name: product_params[:title], kind: 'unexisting' } } 

        it 'returns http unprocessable_entity' do
          post :create, params: product_params_title_and_wrong_kind, format: :json
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'does not save the new product' do
          expect { post :create, params: product_params_title_and_wrong_kind, format: :json }.to_not change(Product, :count)
        end
      end

      context 'Create only with :title and :kind' do
        let(:product_params_title_and_kind) { { name: product_params[:title], kind: product_params[:kind][:title] } } 
        
        it 'returns http success' do
          post :create, params: product_params_title_and_kind, format: :json
          expect(response).to have_http_status(:created)
        end

        it 'saves the new product' do
          expect{ post :create, params: product_params_title_and_kind, format: :json }.to change(Product, :count).by(1)
        end
      end
    end
  end

  describe 'POST #update' do
    let(:product) { create(:product) }

    context 'Guest user' do
      it 'redirect to login' do
        get :show, params: { id: product.id }, format: :json
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
