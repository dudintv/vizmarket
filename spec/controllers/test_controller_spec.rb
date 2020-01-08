require 'rails_helper'

RSpec.describe TestController, type: :controller do

  describe "GET #colors" do
    it "returns http success" do
      get :colors
      expect(response).to have_http_status(:success)
    end
  end

end
