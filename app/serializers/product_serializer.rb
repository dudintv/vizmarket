class ProductSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :title, :short_description, :description, :instruction, :videos, :youtube_ids, :price, :price_original, :public, :featured
  
  attribute :kind do |object|
    object.kind&.title
  end

  attribute :categories do |object|
    object.categories&.pluck(:title)
  end
end
