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
    @product = Product.includes(:versions, :author, :kind, :categories).find(params[:id])
    @product_decorator = @product.decorate
  end

  def scripts
    redirect_to action: :index, kind: 'script'
  end

  def shaders
    redirect_to action: :index, kind: 'shader'
  end

  def scenes
    redirect_to action: :index, kind: 'scene'
  end

  def plugins
    redirect_to action: :index, kind: 'plugin'
  end

  def tutorials
    redirect_to action: :index, kind: 'tutorial'
  end

  private

  def set_selected_menu_item
    @selected = action_name
  end
end
