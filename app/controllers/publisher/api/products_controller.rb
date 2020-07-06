class Publisher::Api::ProductsController < ApplicationController
  before_action :authenticate_user!

  def index
    @products = current_user.products
    render json: ProductSerializer.new(@products).serialized_json
  end

  def show
    @product = Product.find_by(id: params[:id]) # avoid raising exception with Product#find()
    if @product
      render json: ProductSerializer.new(@product).serialized_json
    else
      render json: "Can't find product with id: #{params[:id]}", status: :not_found
    end
  end

  def create
    @kind = Kind.find_by(title: params[:kind])
    @product = Product.new(title: params[:name], user: current_user, kind: @kind)

    if @product.save
      render json: ProductSerializer.new(@product).serialized_json, status: :created
    else
      render json: @product.errors.as_json, status: :unprocessable_entity
    end
  end
end
