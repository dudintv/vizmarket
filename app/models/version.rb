class Version < ApplicationRecord
  belongs_to :product
  has_one :script
  has_many_attached :files

  default_scope { order(created_at: :asc) }
end
