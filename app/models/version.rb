class Version < ApplicationRecord
  belongs_to :product
  has_one :script
  has_many_attached :files
end
