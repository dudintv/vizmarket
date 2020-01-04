require 'rails_helper'

RSpec.describe Creator::ProductsController, type: :controller do

  describe "GET #index" do
    sign_in_user
    
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

end
