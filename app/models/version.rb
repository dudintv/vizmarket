class Version < ApplicationRecord
  belongs_to :product
  has_many_attached :files
end
