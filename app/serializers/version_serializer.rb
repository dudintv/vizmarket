class VersionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :product_id, 
             :number, :public,
             :created_at, :updated_at
end
