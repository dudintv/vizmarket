require 'rails_helper'

RSpec.describe Publisher::Api::VersionsController, type: :controller do

  describe 'GET #index' do
    let(:product) { create :product }

    def make_request
      get :index, params: { product_id: product.id }, format: :json
    end

    it_behaves_like 'Authorizable version'

    context 'Authenticated non-author-user' do
      sign_in_user

      it 'doesn\'t find versions' do
        make_request
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'GET #show' do
    let(:version) { create :version }

    def make_request
      get :show, params: { id: version.id }, format: :json
    end

    it_behaves_like 'Authorizable version'

    context 'Authenticated non-author-user' do
      sign_in_user

      it 'doesn\'t find the version' do
        make_request
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST #create' do
    let(:product) { create :product }
    let(:file_1) { fixture_file_upload('spec/fixtures/files/text1.txt', 'text/plain') }
    let(:file_2) { fixture_file_upload('spec/fixtures/files/text2.txt', 'text/plain') }
    let(:file_3) { fixture_file_upload('spec/fixtures/files/text3.txt', 'text/plain') }
    
    it_behaves_like 'Authorizable version'
    
    def make_request(params = {})
      post :create, params: { 
        product_id: product.id, 
        version: { 
          files: [file_1, file_2, file_3]
        }, 
      }.merge(params), format: :json
    end
    
    context 'Authenticated author-user' do
      before do
        sign_in product.user
      end
      
      it 'creates new version' do
        expect { make_request }.to change{ product.versions.count }.by(1)
      end
      
      context 'Without script' do
        let(:scene_product) { create :scene_product }

        it 'doesn\'t create a script when it hasn\'t script' do
          expect { make_request }.to_not change{ Script.all.count }
        end

        it 'doesn\'t create a script when it isn\'t \'script\' kind' do
          expect { make_request({ product_id: scene_product.id, version: { script: 'Dim a As Alpha' } }) }.to_not change{ Script.all.count }
        end
      end

      context 'With script' do
        it 'creates a script' do
          expect { make_request({ version: { script: 'Dim a As Alpha' } }) }.to change{ Script.all.count }.by(1)
        end
      end
    end

    context 'Authenticated non-author-user' do
      sign_in_user

      it 'doesn\'t create a new version' do
        expect { make_request }.to_not change{ product.versions.count }
      end
    end
  end

  describe 'POST #update' do
    let(:version) { create :version }

    def make_request(params = {})
      post :update, params: {
        id: version.id, 
        version: { number: version.number + 123 }
      }.merge(params), format: :json
    end

    it_behaves_like 'Authorizable version'

    context 'Authenticated author-user' do
      before do
        sign_in version.product.user
      end

      it 'updates the version' do
        expect {
          make_request
          version.reload
        }.to change{ version.number }.by(123)
      end

      context 'without script' do
        let(:scene_version) { update :scene_version }

        it 'doesn\'t update a script when it hasn\'t script' do
          expect { make_request }.to_not change{ version.script }
        end

        it 'doesn\'t update a script when it isn\'t \'script\' kind' do
          expect { make_request({ id: version.id, version: { script: 'Dim a As Alpha' } }) }.to_not change{ version.script }
        end
      end

      context 'with script' do
        let (:script_version) { create :script_version }

        before do
          sign_in script_version.product.user
        end

        it 'updates a script' do
          expect { make_request({ id: script_version.id, version: { script: 'Dim c As Container' } }) }.to change{ script_version.script.reload.script }
        end
      end
    end

    context 'Authenticated non-author-user' do
      sign_in_user

      it 'doesn\'t update the version' do
        expect {
          make_request
          version.reload
        }.to_not change{ version.number }
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:product) { create :product, :with_versions }

    def make_request
      delete :destroy, params: {
        id: product.versions.first.id
      }, format: :json
    end

    it_behaves_like 'Authorizable version'

    context 'Authenticated author-user' do
      before do
        sign_in product.user
      end

      it 'deletes the version' do
        expect { make_request }.to change{ product.versions.count }.by(-1)
      end
    end

    context 'Authenticated non-author-user' do
      sign_in_user

      it 'doesn\'t deletes the version' do
        expect { make_request }.to_not change{ product.versions.count }
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

    it_behaves_like 'Authorizable version'

    context 'Authenticated author-user' do
      before do
        sign_in version.product.user
      end

      it 'changes count of files' do
        expect {
          make_request
          version.reload
        }.to change{ version.files.count }.by(2)
      end
    end
    
    context 'Authenticated non-author-user' do
      sign_in_user

      it 'doesn\'t change count of files' do
        expect {
          make_request
          version.reload
        }.to_not change{ version.files.count }
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

    it_behaves_like 'Authorizable version'

    context 'Authenticated author-user' do
      before do
        sign_in version.product.user
      end

      it 'changes count of files down' do
        expect {
          make_request
          version.reload
        }.to change{ version.files.count }.by(-1)
      end
    end

    context 'Authenticated non-author-user' do
      sign_in_user

      it 'doesn\'t change count of files down' do
        expect {
          make_request
          version.reload
        }.to_not change{ version.files.count }
      end
    end
  end

  describe 'POST #publish' do
    let(:version) { create(:draft_version) }

    def make_request
      post :publish, params: { id: version.id }, format: :json
    end

    it_behaves_like 'Authorizable version'

    context 'Authenticated author-user' do
      before do
        sign_in version.product.user
      end

      it 'makes version publish' do
        expect {
          make_request
          version.reload
        }.to change { version.public }.to true
      end
    end

    context 'Authenticated non-author-user' do
      sign_in_user

      it 'doesn\'t make version publish' do
        expect {
          make_request
          version.reload
        }.to_not change { version.public }
      end
    end
  end

  describe 'POST #unpublish' do
    let(:version) { create(:version) }

    def make_request
      post :unpublish, params: { id: version.id }, format: :json
    end

    it_behaves_like 'Authorizable version'

    context 'Authenticated author-user' do
      before do
        sign_in version.product.user
      end

      it 'makes version unpublish' do
        expect {
          make_request
          version.reload
        }.to change { version.public }.to false
      end
    end

    context 'Authenticated non-author-user' do
      sign_in_user

      it 'doesn\'t make version unpublish' do
        expect {
          make_request
          version.reload
        }.to_not change { version.public }
      end
    end
  end
end
