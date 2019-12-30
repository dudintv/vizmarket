class Authorization < ApplicationRecord
  belongs_to :user

  def confirm(token)
    if token && token == confirmation_token
      update! confirmed_at: Time.zone.now
      true
    else
      false
    end
  end
end
