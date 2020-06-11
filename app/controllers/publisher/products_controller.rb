class Publisher::ProductsController < ApplicationController
  layout 'publisher'
  before_action :authenticate_user!

  def index
    @user = current_user
    @counts = {
      all: Product.all.count
    }
    @products = Product.all
  end

  def new
  end
end
