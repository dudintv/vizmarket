require 'rails_helper'

RSpec.describe Publisher::Api::UserController, type: :controller do

  describe "GET #show" do
    def make_request
      get :show, format: :json
    end
  
    it_behaves_like 'Authorizable with json'
  end

end
