require 'rails_helper'

RSpec.describe Publisher::Api::VersionsController, type: :controller do

  describe 'GET #index' do
    let(:product) { create :product }

    def make_request
      get :index, params: { product_id: product.id }, format: :json
    end

    it_behaves_like 'Authorizable'
  end

  describe 'GET #show' do
    let(:version) { create :version }

    def make_request
      get :show, params: { id: version.id }, format: :json
    end

    it_behaves_like 'Authorizable'
  end

  describe 'POST #create' do
    let(:product) { create :product }
    let(:file_1) { fixture_file_upload('spec/fixtures/files/text1.txt', 'text/plain') }
    let(:file_2) { fixture_file_upload('spec/fixtures/files/text2.txt', 'text/plain') }
    let(:file_3) { fixture_file_upload('spec/fixtures/files/text3.txt', 'text/plain') }
    
    it_behaves_like 'Authorizable'

    def make_request
      post :create, params: { product_id: product.id, version: { files: [file_1, file_2, file_3] } }, format: :json
    end

    context 'Authenticated user' do
      sign_in_user
      
      it 'creates new version' do
        expect { make_request }.to change{ product.versions.count }.by(1)
      end
    end
  end

  describe 'POST #update' do
    let(:version) { create :version }

    def make_request
      post :update, params: {
        id: version.id, 
        version: { number: version.number + 123 }
      }, format: :json
    end

    it_behaves_like 'Authorizable'

    context 'Authenticated user' do
      sign_in_user

      it 'updates the version' do
        expect {
          make_request
          version.reload
        }.to change{ version.number }.by(123)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:product_with_versions) { create :product, :with_versions }

    def make_request
      delete :destroy, params: {
        id: product_with_versions.versions.first.id
      }, format: :json
    end

    it_behaves_like 'Authorizable'

    context 'Authenticated user' do
      sign_in_user

      it 'updates the version' do
        expect { make_request }.to change{ product_with_versions.versions.count }.by(-1)
      end
    end
  end
  
  describe 'PATCH #upload_files' do
    let(:version) { create :version_with_one_file }
    let(:file_2) { fixture_file_upload('spec/fixtures/files/text2.txt', 'text/plain') }
    let(:file_3) { fixture_file_upload('spec/fixtures/files/text3.txt', 'text/plain') }

    def make_request
      post :upload_files, params: {
        id: version.id, 
        files: [file_2, file_3]
      }, format: :json
    end

    it_behaves_like 'Authorizable'

    context 'Authenticated user' do
      sign_in_user

      it 'change count of files' do
        expect {
          make_request
          version.reload
        }.to change{ version.files.count }.by(2)
      end
    end
  end

  describe 'PATCH #delete_files' do
    let(:version) { create :version_with_files }

    def make_request
      post :delete_file, params: {
        id: version.id, 
        key: version.files[0].blob.key
      }, format: :json
    end

    it_behaves_like 'Authorizable'

    context 'Authenticated user' do
      sign_in_user

      it 'change count of files down' do
        expect {
          make_request
          version.reload
        }.to change{ version.files.count }.by(-1)
      end
    end
  end

  describe 'POST #publish' do
    let(:version) { create(:draft_version) }

    def make_request
      post :publish, params: { id: version.id }, format: :json
    end

    it_behaves_like 'Authorizable'

    context 'Authenticated user' do
      sign_in_user

      it 'make version publish' do
        expect {
          make_request
          version.reload
        }.to change { version.public }.to true
      end
    end
  end

  describe 'POST #unpublish' do
    let(:version) { create(:version) }

    def make_request
      post :unpublish, params: { id: version.id }, format: :json
    end

    it_behaves_like 'Authorizable'

    context 'Authenticated user' do
      sign_in_user

      it 'make version unpublish' do
        expect {
          make_request
          version.reload
        }.to change { version.public }.to false
      end
    end
  end
end
