class CategoriesController < ApplicationController
  layout 'products'
  
  def show
    if params[:title]
      if params[:title] =~ (/^\d*$/)
        @products = Category.find(params[:title]).products
      else
        @products = Category.find_by(title: params[:title]).products
      end
    else
      @products = nil
    end
  end
end
