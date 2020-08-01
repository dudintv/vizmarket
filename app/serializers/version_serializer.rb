class VersionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :product_id, 
             :number, :public, :support,
             :created_at, :updated_at
  
  attribute :files do |object|
    if object.files.attached?
      object.files.map do |file|
        {
          url: Rails.application.routes.url_helpers.rails_blob_url(file, only_path: true),
          filename: file.blob.filename.to_s,
          key: file.blob.key
        }
      end
    else
      nil
    end
  end
end
