class Product < ApplicationRecord
  belongs_to :user
  belongs_to :kind
  has_and_belongs_to_many :categories
  
  validates :title, :kind, :user, presence: true
end
