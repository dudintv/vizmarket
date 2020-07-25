require 'rails_helper'

RSpec.describe Publisher::Api::ProductsController, type: :controller do

  describe 'GET #index' do
    def make_request
      get :index, format: :json
    end

    it_behaves_like 'Authorizable'
  end

  describe 'GET #show' do
    let(:product) { create(:product) }

    def make_request
      get :show, params: { id: product.id }, format: :json
    end

    it_behaves_like 'Authorizable'

    context 'Authenticated user' do
      sign_in_user

      context 'With wrong id' do
        it 'return not_found (404)' do
          get :show, params: { id: product.id + 1 }, format: :json
          expect(response).to have_http_status(:not_found)
        end
      end
    end
  end

  describe 'POST #create' do
    let(:product_params) { attributes_for(:product) }
    let(:product_params_title_and_kind) { { name: product_params[:title], kind: product_params[:kind][:title] } } 

    def make_request
      post :create, params: product_params_title_and_kind, format: :json
    end

    it_behaves_like 'Authorizable'

    context 'Guest user' do
      it 'does not save the new product' do
        expect { make_request }.to_not change(Product, :count)
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

    def make_request
      patch :update, params: {
        id: product.id,
        kind: "assets",
        categories: ["utility", "other"],
        product: {
          title: "#{product.title} updated",
          short_description: "#{product.short_description} updated"
        }
      }, format: :json
    end
    
    it_behaves_like 'Authorizable'

    context 'Authenticated user' do
      sign_in_user

      context 'Update on "Title & Category" page' do
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
    end
  end

  describe 'POST #update' do
    let!(:product) { create(:product) }

    def make_request
      delete :destroy, params: { id: product.id }, format: :json
    end
    
    it_behaves_like 'Authorizable'

    context 'Authenticated user' do
      sign_in_user

      it 'destroy the product' do
        expect{
          make_request
        }.to change{ Product.count }.by(-1)
      end
    end
  end

  describe 'POST #upload_thumbnail' do
    let(:product) { create(:product) }
    let(:square_image) { fixture_file_upload('spec/fixtures/images/square568x568.jpg', 'image/jpeg') }

    def make_request
      post :upload_thumbnail, params: {
        id: product.id,
        thumbnail: square_image
      }, format: :json
    end
    
    it_behaves_like 'Authorizable'

    context 'Authenticated user' do
      sign_in_user

      it 'uploads thumbnail image' do
        expect {
          make_request
          product.reload
        }.to change { product.thumbnail.attached? }.to true
      end
    end
  end

  describe 'POST #upload_featured_image' do
    let(:product) { create(:product) }
    let(:image_16_9) { fixture_file_upload('spec/fixtures/images/1920x1080.jpg', 'image/jpeg') }

    def make_request
      post :upload_featured_image, params: {
        id: product.id,
        featured_image: image_16_9
      }, format: :json
    end

    it_behaves_like 'Authorizable'

    context 'Authenticated user' do
      sign_in_user

      it 'uploads featured image' do
        expect {
          make_request
          product.reload
        }.to change { product.featured_image.attached? }.to true
      end
    end
  end

  describe 'POST #upload_gallery_images' do
    let(:product) { create(:product) }
    let(:image_1) { fixture_file_upload('spec/fixtures/images/1920x1080_car.jpg', 'image/jpeg') }
    let(:image_2) { fixture_file_upload('spec/fixtures/images/1920x1080_cubes.jpg', 'image/jpeg') }
    let(:image_3) { fixture_file_upload('spec/fixtures/images/1920x1080_leopard.jpg', 'image/jpeg') }

    def make_request
      post :upload_gallery_images, params: {
        id: product.id,
        images: [
          image_1,
          image_2,
          image_3
        ]
      }, format: :json
    end

    it_behaves_like 'Authorizable'

    context 'Authenticated user' do
      sign_in_user

      it 'uploads many images for the gallery' do
        expect {
          make_request
          product.reload
        }.to change { product.images.attached? }.to true
      end
    end
  end

  describe 'POST #publish' do
    let(:product) { create(:draft_product) }

    def make_request
      post :publish, params: { id: product.id }, format: :json
    end

    it_behaves_like 'Authorizable'

    context 'Authenticated user' do
      sign_in_user

      it 'make product publish' do
        expect {
          make_request
          product.reload
        }.to change { product.public }.to true
      end
    end
  end

  describe 'POST #unpublish' do
    let(:product) { create(:product) }

    def make_request
      post :unpublish, params: { id: product.id }, format: :json
    end

    it_behaves_like 'Authorizable'

    context 'Authenticated user' do
      sign_in_user

      it 'make product unpublish' do
        expect {
          make_request
          product.reload
        }.to change { product.public }.to false
      end
    end
  end

  describe 'DELETE #delete_thumbnail' do
    let(:product) { create(:product_with_images) }

    def make_request
      delete :delete_thumbnail, params: { id: product.id }, format: :json
    end

    it_behaves_like 'Authorizable'

    context 'Authenticated user' do
      sign_in_user

      it 'deletes thumbnail' do
        expect {
          make_request
          product.reload
        }.to change { product.thumbnail.attached? }.to false
      end
    end
  end

  describe 'DELETE #delete_featured_image' do
    let(:product) { create(:product_with_images) }

    def make_request
      delete :delete_featured_image, params: { id: product.id }, format: :json
    end

    it_behaves_like 'Authorizable'

    context 'Authenticated user' do
      sign_in_user

      it 'deletes featured image' do
        expect {
          make_request
          product.reload
        }.to change { product.featured_image.attached? }.to false
      end
    end
  end

  describe 'DELETE #delete_image' do
    let(:product_with_images) { create(:product_with_images) }

    def make_request
      delete :delete_image, params: { key: product_with_images.images[0].blob.key }, format: :json
    end

    it_behaves_like 'Authorizable'

    context 'Authenticated user' do
      sign_in_user

      it 'deletes featured image' do
        expect {
          make_request
          product_with_images.reload
        }.to change { product_with_images.images.count }.from(3).to(2)
      end
    end
  end
end
