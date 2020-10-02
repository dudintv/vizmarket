class Author < ApplicationRecord
  belongs_to :user
  has_many :products

  validates :name, presence: true

  def set_as_completed
    if valid?
      update(completed: true)
    end
  end
end
