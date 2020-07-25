class Publisher::Api::VersionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [:index, :create]
  before_action :set_version, only: [:show, :update, :destroy, :upload_files, :delete_file]

  def index
    render json: VersionSerializer.new(@product.versions).serialized_json
  end
  
  def show
    render json: VersionSerializer.new(@versions).serialized_json
  end

  def create
    @version = Version.new(version_params.merge(product: @product))
    if @version.save
      render json: VersionSerializer.new(@version).serialized_json, status: :created
    else
      render json: @product.errors.as_json, status: :unprocessable_entity
    end
  end

  def update
    if @version.update(version_params)
      render json: VersionSerializer.new(@version.reload).serialized_json, status: :ok
    else
      render json: @version.errors.as_json, status: :unprocessable_entity
    end
  end

  def destroy
    if @version.destroy
      render json: {id: @version.id, number: @version.number}, status: :ok
    else
      render json: @version.errors.as_json, status: :unprocessable_entity
    end
  end

  def upload_files
    if params[:files]
      if @version.files.attach(params[:files])
        render json: VersionSerializer.new(@version.reload).serialized_json, status: :ok
      else
        render json: @version.errors.as_json, status: :unprocessable_entity
      end
    end
  end

  def delete_file
    @file = ActiveStorage::Blob.find_by_key(params[:key])
    @file&.attachments&.first.purge
    render json: {}, status: :ok
  end

  private

  def set_product
    @product = Product.find_by(id: params[:product_id])

    until @product
      render json: "Can't find product with id: #{params[:product_id]}", status: :not_found
      return
    end
  end

  def set_version
    @version = Version.find_by(id: params[:id])

    until @version
      render json: "Can't find version with id: #{params[:id]}", status: :not_found
      return
    end
  end

  def version_params
    params.require(:version).permit(:number, files: [])
  end
end
