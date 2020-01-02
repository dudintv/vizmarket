class AuthorizationMailer < ApplicationMailer
  def confirmation
    @auth = Authorization.unscoped.find(params[:id])

    mail to: @auth.user.email
  end
end
