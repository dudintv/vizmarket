class Version < ApplicationRecord
  belongs_to :product, touch: true
  has_one :script, dependent: :destroy
  has_many_attached :files

  default_scope { order(created_at: :desc) }
  scope :published, -> { where(public: true) }
end
