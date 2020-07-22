class VersionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :number,
             :created_at, :updated_at

end