require 'rails_helper'

RSpec.describe TestController, type: :controller do

  describe "GET #test" do
    it "returns http success" do
      get :test
      expect(response).to have_http_status(:success)
    end
  end

end
