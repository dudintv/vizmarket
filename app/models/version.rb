class Version < ApplicationRecord
  belongs_to :product, touch: true
  has_one :script, dependent: :destroy
  has_many_attached :files

  default_scope { where(public: true).order(created_at: :desc) }
end
