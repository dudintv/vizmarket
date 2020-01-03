class ProductsController < ApplicationController
  before_action :set_selected_menu_item

  def scripts
  end

  def scenes
  end

  def plugins
  end

  def free
  end

  def vault
  end

  private

  def set_selected_menu_item
    @selected = action_name
  end
end
