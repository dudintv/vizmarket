RSpec.shared_examples 'Authorizable' do
  context 'Guest user' do
    it 'returns http unauthorized' do
      make_request
      expect(response).to have_http_status(:unauthorized) # 401 status
    end
  end

  context 'Authenticated user' do
    sign_in_user
    
    it 'returns http success' do
      make_request
      expect(response).to have_http_status(:success)
    end
  end
end
