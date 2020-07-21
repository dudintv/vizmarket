class Publisher::Api::ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [
    :show, :update, :publish, :unpublish,
    :upload_thumbnail, :upload_featured_image, :upload_gallery_images, 
    :delete_featured_image, :delete_thumbnail,
    :destroy]

  def index
    @products = current_user.products.order(id: :desc)
    render json: ProductSerializer.new(@products).serialized_json
  end

  def show
    render json: ProductSerializer.new(@product).serialized_json
  end

  def create
    @kind = Kind.find_by(title: params[:kind])
    @product = Product.new(title: params[:name], user: current_user, kind: @kind)
    # @categories = Category.where(title: params[:categories])

    if @product.save
      render json: ProductSerializer.new(@product).serialized_json, status: :created
    else
      render json: @product.errors.as_json, status: :unprocessable_entity
    end
  end

  def publish
    if @product.update(public: true)
      render json: {}, status: :ok
    else
      render json: @product.errors.as_json, status: :unprocessable_entity
    end
  end

  def unpublish
    if @product.update(public: false)
      render json: {}, status: :ok
    else
      render json: @product.errors.as_json, status: :unprocessable_entity
    end
  end

  def update
    if params[:kind]
      kind = Kind.find_by(title: params[:kind])
      @product.update(kind: kind)
    end
    
    if params[:categories]
      categories = Category.where(title: params[:categories])
      @product.update(categories: categories)
    end

    if params[:newCategory]
      NewCategory.create(title: params[:newCategory], user: current_user, product: @product)
    end

    if params[:product]
      if @product.update(product_params)
        render json: ProductSerializer.new(@product.reload).serialized_json, status: :ok
      else
        render json: @product.errors.as_json, status: :unprocessable_entity
      end
    end
  end

  def destroy
    if @product.destroy
      render json: {id: @product.id, title: @product.title}, status: :ok
    else
      render json: @product.errors.as_json, status: :unprocessable_entity
    end
  end

  def upload_thumbnail
    if params[:thumbnail]
      if @product.update(thumbnail: params[:thumbnail])
        render json: { thumbnail: @product.thumbnail }, status: :ok
      else
        render json: @product.errors.as_json, status: :unprocessable_entity
      end
    end
  end

  def upload_featured_image
    if params[:featured_image]
      if @product.update(featured_image: params[:featured_image])
        render json: { featured_image: @product.featured_image }, status: :ok
      else
        render json: @product.errors.as_json, status: :unprocessable_entity
      end
    end
  end

  def upload_gallery_images
    if params[:images]
      if @product.images.attach(params[:images])
        render json: ProductSerializer.new(@product).serialized_json, status: :ok
      else
        render json: @product.errors.as_json, status: :unprocessable_entity
      end
    end
  end

  def delete_thumbnail
    @product.thumbnail.purge
    render json: {}, status: :ok
  end

  def delete_featured_image
    @product.featured_image.purge
    render json: {}, status: :ok
  end

  def delete_image
    @image = ActiveStorage::Blob.find_by_key(params[:key])
    if @image&.attachments&.first.purge
      render json: {}, status: :ok
    else
      render json: {}, status: :unprocessable_entity
    end
  end

  private

  def set_product
    @product = Product.with_attached_thumbnail.with_attached_featured_image.with_attached_images.find_by(id: params[:id])

    until @product
      render json: "Can't find product with id: #{params[:id]}", status: :not_found
      return
    end
  end

  def product_params
    params.require(:product).permit(
      :title, :short_description,
      :description, :instruction,
      :videos, :youtube_ids,
      :price,
    )
  end
end
