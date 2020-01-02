class Authorization < ApplicationRecord
  belongs_to :user

  after_create :generate_token, :send_confirmation

  def self.generate(params)
    user = User.generate(params[:email])
    Authorization.find_or_create_by(provider: params[:provider], uid: params[:uid], user: user)
  end

  def confirm(token)
    if token && token == confirmation_token
      update! confirmed_at: Time.zone.now
      true
    else
      false
    end
  end

  def send_confirmation
    AuthorizationMailer.with(id: id).confirmation.deliver_now unless confirmed_at
  end

  private

  def generate_token
    update! confirmation_token: Devise.friendly_token(20)
  end
end
