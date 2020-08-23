class AuthorSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :title, :links, :support_contacts, :private_contacts
end
