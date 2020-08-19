class Author < ApplicationRecord
  belongs_to :user

  validates :name, presence: true

  def set_as_completed
    if valid?
      update(completed: true)
    end
  end
end
