require 'rails_helper'

RSpec.describe Publisher::ProductsController, type: :controller do

  describe 'GET #index' do
    def make_request
      get :index
    end
    
    it_behaves_like 'Authorizable with redirect to login'
  end

end
