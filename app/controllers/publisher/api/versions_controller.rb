class Publisher::Api::VersionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product

  def index
    render json: VersionSerializer.new(@product.versions).serialized_json
  end

  def show
  end

  def create
  end

  def update
  end

  def destroy
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end
end
