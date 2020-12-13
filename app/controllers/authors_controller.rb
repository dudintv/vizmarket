class AuthorsController < ApplicationController
  layout 'products'

  def show
    @author = Author.includes(:products).find(params[:id])
    @products = @author.products
  end
end
