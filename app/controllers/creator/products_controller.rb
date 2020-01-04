class Creator::ProductsController < ApplicationController
  layout 'creator'
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
