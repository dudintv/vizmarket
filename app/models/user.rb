class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :omniauthable, omniauth_providers: %i[facebook google]
  has_many :authorizations, dependent: :destroy

  def self.generate(email)
    user = User.where(email: email).first
    return user if user

    password = Devise.friendly_token(10)
    user = User.new(email: email, password: password, password_confirmation: password)
    user.skip_confirmation!
    user.save!
    user
  end

  def self.from_omniauth(auth)
    authorization = Authorization.where(provider: auth.provider, uid: auth.uid).first
    return authorization.user if authorization

    email = auth.info[:email]
    user = User.where(email: email).first
    if user
      # if user with the email is already exist
      user.authorizations.create(provider: auth.provider, 
                                 uid: auth.uid,
                                 confirmed_at: Time.zone.now)
    else
      # if user is a new one
      user = User.generate(email)
      user.authorizations.create(provider: auth.provider, 
                                 uid: auth.uid,
                                 confirmed_at: Time.zone.now)
    end
    user
  end
end
