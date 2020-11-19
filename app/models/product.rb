class Product < ApplicationRecord
  belongs_to :user
  belongs_to :author
  belongs_to :kind
  has_and_belongs_to_many :categories
  has_many :versions
  has_one_attached :thumbnail
  has_one_attached :featured_image
  has_many_attached :images

  default_scope { where(public: true) }
  
  validates :title, :kind, :user, presence: true
end
