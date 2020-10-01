class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :email, :name, :surname, :jobtitle, :country, :about

  attribute :avatar do |object|
    if object.avatar.attached?
      Rails.application.routes.url_helpers.rails_representation_url( object.avatar.variant(resize: "260x260").processed, only_path: true )
    else
      nil
    end
  end

  attribute :isAuthor do |object|
    object.is_author?
  end

  attribute :linkedAccounts do |object|
    object.authorizations.map(&:provider)
  end
end
