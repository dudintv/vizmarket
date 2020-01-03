class AuthorizationsController < ApplicationController
  # skip_after_action :verify_authorized
  layout 'account'
  
  def confirm
    authorization = Authorization.find(params[:id])
    if authorization.confirm(params[:token])
      success_omniauth_sign_in(authorization.user, authorization.provider)
    else
      flash[:alert] = 'Confirmation code is not actual.'
      redirect_to root_path
    end
  end

  def create
    @authorization = Authorization.generate(provider: session[:auth]['provider'], uid: session[:auth]['uid'], email: params[:email])
    session[:auth] = nil
    render 'authorization/send_confirmation'
  end

  def resend
    Authorization.find(params[:id])&.send_confirmation
    flash[:notice] = 'Confirmation code was sended.'
    redirect_to root_path
  end
end
