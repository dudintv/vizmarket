class ProductSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :title, :short_description, :description, :instruction, :price, :price_original, :public, :featured
end
