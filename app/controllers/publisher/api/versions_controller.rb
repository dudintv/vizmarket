class Publisher::Api::VersionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [:index, :create]
  before_action :set_version, only: [:show, :update, :destroy, 
                                     :upload_files, :delete_file,
                                     :publish, :unpublish]

  def index
    render json: VersionSerializer.new(@product.versions).serialized_json
  end
  
  def show
    render json: VersionSerializer.new(@version).serialized_json
  end

  def create
    @version = Version.new(version_params.merge(product: @product))
    if @version.save
      @version.files.attach(params[:version][:files]) if params.dig(:version, :files).present?
      if params[:version][:script].present? && @product.kind.title == 'script'
        Script.create(version: @version, script: params[:version][:script])
      end
      render json: VersionSerializer.new(@version).serialized_json, status: :created
    else
      render json: @product.errors.as_json, status: :unprocessable_entity
    end
  end

  def update
    if @version.update(version_params)
      @version.files.attach(params[:version][:files]) if params.dig(:version, :files).present?
      if params.dig(:version, :remove_files).present?
        params[:version][:remove_files].each do |file_id|
          @version.files.find(file_id).purge
        end
      end
      if params[:version][:script].present? && @version.product.kind.title == 'script'
        if @version.script.present?
          @version.script.update(script: params[:version][:script])
        else
          @version.create_script(script: params[:version][:script])
        end
      end
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

  def publish
    if @version.update(public: true)
      render json: {id: @version.id, public: @version.public}, status: :ok
    else
      render json: @version.errors.as_json, status: :unprocessable_entity
    end
  end
  
  def unpublish
    if @version.update(public: false)
      render json: {id: @version.id, public: @version.public}, status: :ok
    else
      render json: @version.errors.as_json, status: :unprocessable_entity
    end
  end

  private

  def set_product
    @product = Product.find_by(id: params[:product_id])

    # until @product
    if !@product || @product.user != current_user
      render json: "Can't find product with id: #{params[:product_id]}", status: :not_found
      return
    end
  end

  def set_version
    @version = Version.find_by(id: params[:id])

    # until @version
    if !@version || @version.product.user != current_user
      render json: "Can't find version with id: #{params[:id]}", status: :not_found
      return
    end
  end

  def version_params
    params.require(:version).permit(:number, :public, :support)
  end
end
