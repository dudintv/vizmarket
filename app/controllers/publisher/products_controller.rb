class Publisher::ProductsController < ApplicationController
  layout 'publisher'
  before_action :authenticate_user!

  def index
  end
end
