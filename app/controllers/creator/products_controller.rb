class Creator::ProductsController < ApplicationController
  layout 'creator'
  before_action :authenticate_user!

  def index
    @user = current_user
    @counts = {
      all: 123 # Product.all.count
    }
    # @products = Product.all
  end
end
