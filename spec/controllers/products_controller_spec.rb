require 'rails_helper'

RSpec.describe ProductsController, type: :controller do

  describe "GET #scripts" do
    it "returns http success" do
      get :scripts
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #scenes" do
    it "returns http success" do
      get :scenes
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #plugins" do
    it "returns http success" do
      get :plugins
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #free" do
    it "returns http success" do
      get :free
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #vault" do
    it "returns http success" do
      get :vault
      expect(response).to have_http_status(:success)
    end
  end

end
