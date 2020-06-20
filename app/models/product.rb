class Product < ApplicationRecord
  belongs_to :user
  belongs_to :kind
  
  validates :title, :kind, :user, presence: true
end
