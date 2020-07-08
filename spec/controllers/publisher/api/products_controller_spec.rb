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

    context 'Authenticated user' do
      sign_in_user

      context 'Update title & category' do
        it 'return success' do
          patch :update, params: {
            id: product.id,
            kind: "assets",
            categories: ["utility", "other"],
            product: {
              title: "#{product.title} updated",
              short_description: "#{product.short_description} updated"
            }
          }
          expect(response).to have_http_status(:success)
        end

        it 'change product\'s kind and categories' do
          expect{
            patch :update, params: {
              id: product.id,
              kind: "assets",
              categories: ["utility", "other"],
            }
            product.reload
          }
          .to change { product.kind }
          .and change { product.categories.pluck(:title) }
        end

        it 'change product\'s title and short_description' do
          expect{
            patch :update, params: {
              id: product.id,
              product: {
                title: "#{product.title} updated",
                short_description: "#{product.short_description} updated"
              }
            }
            product.reload
          }
          .to change { product.title }
          .and change { product.short_description }
        end

        it 'change product\'s description and instruction' do
          expect{
            patch :update, params: {
              id: product.id,
              product: {
                description: "#{product.description} updated",
                instruction: "#{product.instruction} updated"
              }
            }
            product.reload
          }
          .to change { product.description }
          .and change { product.instruction }
        end
      end

      context 'Update Images & Video' do
        
      end

      context 'Update Instructions' do
        
      end

      # Product Files are tested in versions_controller_spec
    end
  end
end
