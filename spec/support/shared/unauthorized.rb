RSpec.shared_examples 'Authorizable product' do
  context 'Guest user' do
    it 'returns http unauthorized' do
      make_request
      expect(response).to have_http_status(:unauthorized) # 401 status
    end
  end

  context 'Authenticated user' do
    before do
      if defined? product
        sign_in product.user
      else
        sign_in create(:user)
      end
    end

    it 'returns http success' do
      make_request
      expect(response).to have_http_status(:success)
    end
  end
end

RSpec.shared_examples 'Authorizable version' do
  context 'Guest user' do
    it 'returns http unauthorized' do
      make_request
      expect(response).to have_http_status(:unauthorized) # 401 status
    end
  end

  context 'Authenticated user' do
    before do
      if defined? version
        sign_in version.product.user
      elsif defined? product
        sign_in product.user
      else
        sign_in create(:user)
      end
    end

    it 'returns http success' do
      make_request
      expect(response).to have_http_status(:success)
    end
  end
end
