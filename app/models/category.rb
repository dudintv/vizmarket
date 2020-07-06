class Category < ApplicationRecord
  has_and_belongs_to_many :products
  
  validates :title, presence: true, uniqueness: true
end
