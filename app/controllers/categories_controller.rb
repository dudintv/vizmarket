class CategoriesController < ApplicationController
  def show
    if params[:title]
      @products = Category.find_by(title: params[:title]).products
    else
      @products = nil
    end
  end
end
