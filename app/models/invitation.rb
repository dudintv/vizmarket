class Invitation < ApplicationRecord
  belongs_to :user

  after_create :generate_code

  def generate_code
    update! code: Devise.friendly_token(20)
  end
end
