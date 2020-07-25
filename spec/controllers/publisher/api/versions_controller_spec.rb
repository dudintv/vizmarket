require 'rails_helper'

RSpec.describe Publisher::Api::VersionsController, type: :controller do

  describe 'GET #index' do
    let(:product) { create :product }

    context 'Guest user' do
      it 'returns http unauthorized' do
        get :index, params: { product_id: product.id }, format: :json
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'Authenticated user' do
      sign_in_user
      
      it 'returns http success' do
        get :index, params: { product_id: product.id }, format: :json
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'GET #show' do
    let(:version) { create :version }

    context 'Guest user' do
      it 'returns http unauthorized' do
        get :show, params: { product_id: version.product.id, id: version.id }, format: :json
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'Authenticated user' do
      sign_in_user
      
      it 'returns http success' do
        get :show, params: { product_id: version.product.id, id: version.id }, format: :json
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'POST #create' do
    let(:product) { create :product }

    context 'Guest user' do
      it 'returns http unauthorized' do
        post :create, params: { product_id: product.id }, format: :json
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'Authenticated user' do
      sign_in_user

      let(:file_1) { fixture_file_upload('spec/fixtures/files/text1.txt', 'text/plain') }
      let(:file_2) { fixture_file_upload('spec/fixtures/files/text2.txt', 'text/plain') }
      let(:file_3) { fixture_file_upload('spec/fixtures/files/text3.txt', 'text/plain') }
      
      it 'returns http success' do
        post :create, params: { product_id: product.id, version: { files: [file_1, file_2, file_3] } }, format: :json
        expect(response).to have_http_status(:success)
      end

      it 'creates new version' do
        expect {
          post :create, params: { 
              product_id: product.id, 
              version: { files: [file_1, file_2, file_3] } 
            }, format: :json
        }.to change{ product.versions.count }.by(1)
      end
    end
  end

  describe 'POST #update' do
    let(:product_with_version) { create :product, :with_one_version }

    context 'Guest user' do
      it 'returns http unauthorized' do
        post :update, params: { product_id: product_with_version.id, id: product_with_version.versions.first.id }, format: :json
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'Authenticated user' do
      sign_in_user
      
      it 'returns http success' do
        post :create, params: { 
          product_id: product_with_version.id, 
          id: product_with_version.versions.first.id, 
          version: { number: product_with_version.versions.first.number + 123 }
        }, format: :json
        expect(response).to have_http_status(:success)
      end

      it 'updates the version' do
        expect {
          post :update, params: { 
            product_id: product_with_version.id, 
            id: product_with_version.versions.first.id, 
            version: { number: product_with_version.versions.first.number + 123 }
          }, format: :json
          product_with_version.versions.first.reload
        }.to change{ product_with_version.versions.first.number }.by(123)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:product_with_versions) { create :product, :with_versions }

    context 'Guest user' do
      it 'returns http unauthorized' do
        delete :destroy, params: { product_id: product_with_versions.id, id: product_with_versions.versions.first.id }, format: :json
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'Authenticated user' do
      sign_in_user
      
      it 'returns http success' do
        delete :destroy, params: { 
          product_id: product_with_versions.id, 
          id: product_with_versions.versions.first.id
        }, format: :json
        expect(response).to have_http_status(:success)
      end

      it 'updates the version' do
        expect {
          delete :destroy, params: { 
            product_id: product_with_versions.id, 
            id: product_with_versions.versions.first.id
          }, format: :json
        }.to change{ product_with_versions.versions.count }.by(-1)
      end
    end
  end

  describe 'PATCH #upload_files' do
    let(:version) { create :version_with_one_file }

    context 'Guest user' do
      it 'returns http unauthorized' do
        post :upload_files, params: { product_id: version.product.id, id: version.id }, format: :json
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'Authenticated user' do
      sign_in_user

      let(:file_2) { fixture_file_upload('spec/fixtures/files/text2.txt', 'text/plain') }
      let(:file_3) { fixture_file_upload('spec/fixtures/files/text3.txt', 'text/plain') }
      
      it 'returns http success' do
        post :upload_files, params: { 
          product_id: version.product.id, 
          id: version.id, 
          files: [file_2, file_3]
        }, format: :json
        expect(response).to have_http_status(:success)
      end

      it 'change count of files' do
        expect {
          post :upload_files, params: { 
            product_id: version.product.id, 
            id: version.id, 
            files: [file_2, file_3]
          }, format: :json
          version.reload
        }.to change{ version.files.count }.by(2)
      end
    end
  end

  describe 'PATCH #delete_files' do
    let(:version) { create :version_with_files }

    context 'Guest user' do
      it 'returns http unauthorized' do
        post :delete_file, params: { product_id: version.product.id, id: version.id }, format: :json
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'Authenticated user' do
      sign_in_user
      
      it 'returns http success' do
        post :delete_file, params: { 
          product_id: version.product.id, 
          id: version.id, 
          key: version.files[0].blob.key
        }, format: :json
        expect(response).to have_http_status(:success)
      end

      it 'change count of files down' do
        expect {
          post :delete_file, params: { 
            product_id: version.product.id, 
            id: version.id, 
            key: version.files[0].blob.key
          }, format: :json
          version.reload
        }.to change{ version.files.count }.by(-1)
      end
    end
  end
end
