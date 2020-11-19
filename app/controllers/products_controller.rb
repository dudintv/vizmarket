class ProductsController < ApplicationController
  before_action :set_selected_menu_item

  def index
    if params[:kind]
      @products = Kind.find_by(title: params[:kind]).products
    else
      @products = Product.all
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def scripts
    redirect_to action: :index, kind: 'script'
  end

  def scenes
    redirect_to action: :index, kind: 'scene'
  end

  def plugins
    redirect_to action: :index, kind: 'plugin'
  end

  private

  def set_selected_menu_item
    @selected = action_name
  end
end
