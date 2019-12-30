class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, 
         :omniauthable, omniauth_providers: %i[facebook]
  has_many :authorizations, dependent: :destroy

  def self.from_omniauth(auth)
    authorization = Authorization.where(provider: auth.provider, uid: auth.uid).first
    return authorization.user if authorization

    email = auth.info[:email]
    user = User.where(email: email).first
    if user
      # if user with the email is already exist
      user.authorizations.create(provider: auth.provider, 
                                 uid: auth.uid)
    else
      # if user is a new one
      user = User.generate(email)
      user.authorizations.create(provider: auth.provider, 
                                 uid: auth.uid)
    end
    user
  end
end
