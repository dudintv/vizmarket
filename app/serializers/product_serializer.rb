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
      Rails.application.routes.url_helpers.rails_blob_url(object.thumbnail, only_path: true)
    else
      nil
    end
  end

  attribute :idid do |object|
    object.id
  end
end
