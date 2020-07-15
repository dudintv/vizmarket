class ProductSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :title, :short_description, :description, :instruction, :videos, :youtube_ids, :price, :price_original, :public, :featured
  
  attribute :kind do |object|
    object.kind&.title
  end

  attribute :categories do |object|
    object.categories&.pluck(:title)
  end

  attribute :thumbnail do |object|
    if object.thumbnail.attached?
      Rails.application.routes.url_helpers.rails_representation_url( object.thumbnail.variant(resize: "568x568").processed, only_path: true )
    else
      nil
    end
  end

  attribute :featuredImage do |object|
    if object.featured_image.attached?
      Rails.application.routes.url_helpers.rails_representation_url( object.featured_image.variant(resize: "818x460").processed, only_path: true )
    else
      nil
    end
  end

  attribute :images do |object|
    if object.images.attached?
      object.images.map do |image|
        {
          image: Rails.application.routes.url_helpers.rails_blob_url(image, only_path: true),
          image_preview: Rails.application.routes.url_helpers.rails_representation_url( image.variant(resize: "200x200").processed, only_path: true ),
          filename: image.blob.filename.to_s,
          key: image.blob.key
        }
      end
    else
      nil
    end
  end
end
