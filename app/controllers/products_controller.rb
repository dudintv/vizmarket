class ProductsController < ApplicationController
  def index
    if params[:kind]
      @products = Kind.find_by(title: params[:kind]).products.published
      @selected = params[:kind].pluralize
    else
      @products = Product.published
    end
  end

  def show
    begin
      @product = Product.published.find(params[:id])

      if current_user != @product.user
        result = @product.update(show_stat: @product.show_stat ? @product.show_stat + 1 : 1)
      end
      @product_decorator = @product.decorate

    rescue ActiveRecord::RecordNotFound => e
      flash[:warning] = 'Can\'t find this product. ' # + e.message
      redirect_to root_path
    end
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
end
