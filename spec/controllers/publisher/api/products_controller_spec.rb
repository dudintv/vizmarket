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

      context 'Update on "Title & Category" page' do
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

        context 'when user advise a new category' do
          it 'dont create empty NewCategory' do
            expect{
              patch :update, params: {
                id: product.id,
                newCategory: ''
              }
              product.reload
            }
            .to_not change { NewCategory.count }
          end

          it 'create NewCategory if it presence' do
            expect{
              patch :update, params: {
                id: product.id,
                newCategory: 'My category'
              }
              product.reload
            }
            .to change { NewCategory.count }.by(1)
          end
        end
      end

      context 'Update Images & Video' do
        it 'change product\'s videos and youtube_ids' do
          expect{
            patch :update, params: {
              id: product.id,
              product: {
                videos: "https://www.youtube.com/watch?v=JMP3x9OffBM",
                youtube_ids: "JMP3x9OffBM"
              }
            }
            product.reload
          }
          .to change { product.videos }
          .and change { product.youtube_ids }
        end
      end

      context 'Update Instructions' do
        
      end

      # Product Files are tested in versions_controller_spec
    end
  end

  describe 'POST #upload_thumbnail' do
    let(:product) { create(:product) }

    context 'Guest user' do
      it 'redirect to login' do
        post :upload_thumbnail, params: { id: product.id }, format: :json
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'Authenticated user' do
      sign_in_user

      let(:square_image) { fixture_file_upload('spec/fixtures/images/square568x568.jpg', 'image/jpeg') }

      it 'uploads thumbnail image' do
        expect {
          post :upload_thumbnail, params: {
            id: product.id,
            thumbnail: square_image
          }
          product.reload
        }.to change { product.thumbnail.attached? }.to true
      end
    end
  end

  describe 'POST #upload_featured_image' do
    let(:product) { create(:product) }

    context 'Guest user' do
      it 'redirect to login' do
        post :upload_featured_image, params: { id: product.id }, format: :json
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'Authenticated user' do
      sign_in_user

      let(:image_16_9) { fixture_file_upload('spec/fixtures/images/1920x1080.jpg', 'image/jpeg') }

      it 'uploads featured image' do
        expect {
          post :upload_featured_image, params: {
            id: product.id,
            featured_image: image_16_9
          }
          product.reload
        }.to change { product.featured_image.attached? }.to true
      end
    end
  end

  describe 'POST #upload_gallery_images' do
    let(:product) { create(:product) }

    context 'Guest user' do
      it 'redirect to login' do
        post :upload_gallery_images, params: { id: product.id }, format: :json
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'Authenticated user' do
      sign_in_user

      let(:image_1) { fixture_file_upload('spec/fixtures/images/1920x1080_car.jpg', 'image/jpeg') }
      let(:image_2) { fixture_file_upload('spec/fixtures/images/1920x1080_cubes.jpg', 'image/jpeg') }
      let(:image_3) { fixture_file_upload('spec/fixtures/images/1920x1080_leopard.jpg', 'image/jpeg') }

      it 'uploads many images for the gallery' do
        expect {
          post :upload_gallery_images, params: {
            id: product.id,
            images: [
              image_1,
              image_2,
              image_3
            ]
          }
          product.reload
        }.to change { product.images.attached? }.to true
      end
    end
  end

  describe 'DELETE #delete_thumbnail' do
    let(:product) { create(:product_with_images) }

    context 'Guest user' do
      it 'redirect to login' do
        delete :delete_thumbnail, params: { id: product.id }, format: :json
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'Authenticated user' do
      sign_in_user

      it 'deletes thumbnail' do
        expect {
          delete :delete_thumbnail, params: { id: product.id }
          product.reload
        }.to change { product.thumbnail.attached? }.to false
      end
    end
  end

  describe 'DELETE #delete_featured_image' do
    let(:product) { create(:product_with_images) }

    context 'Guest user' do
      it 'redirect to login' do
        delete :delete_featured_image, params: { id: product.id }, format: :json
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'Authenticated user' do
      sign_in_user

      it 'deletes featured image' do
        expect {
          delete :delete_featured_image, params: { id: product.id }
          product.reload
        }.to change { product.featured_image.attached? }.to false
      end
    end
  end

  describe 'DELETE #delete_image' do
    let(:product) { create(:product_with_images) }

    context 'Guest user' do
      it 'redirect to login' do
        delete :delete_image, params: { key: product.images[0].blob.key }, format: :json
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'Authenticated user' do
      sign_in_user

      it 'deletes featured image' do
        expect {
          delete :delete_image, params: { key: product.images[0].blob.key }
          product.reload
        }.to change { product.images.count }.from(3).to(2)
      end
    end
  end
end
