class Product < ApplicationRecord
  include PgSearch::Model
  multisearchable against: [ :title, :short_description, :description ]
  # pg_search_scope :search_product,
  #                 against: { title: 'A', short_description: 'B', description: 'C' },
  #                 using: { tsearch: { dictionary: 'english' } }
  # A, B, C are search priority

  belongs_to :user
  belongs_to :author
  belongs_to :kind
  has_and_belongs_to_many :categories
  has_many :versions
  has_one_attached :thumbnail
  has_one_attached :featured_image
  has_many_attached :images

  default_scope { order('created_at DESC') }
  scope :published, -> { includes(:author, :kind, :categories).where(public: true) }
  
  # default_scope { order('products.created_at DESC') }
  # scope :with_published_versions, -> { includes(:versions).where(versions: { public: true }) }
  
  validates :title, :kind, :user, presence: true

  # Naive approach for pg_search
  def self.rebuild_pg_search_documents
    find_each { |record| record.update_pg_search_document }
  end
  # manual way:
  # PgSearch::Multisearch.rebuild(Product)
end
