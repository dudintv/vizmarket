# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :authorize, except: [:failure]
  layout 'account'

  def facebook; end

  def google; end

  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  def failure
    redirect_to root_path
  end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end

  private

  def authorize
    @auth = request.env['omniauth.auth']
    @authorization = Authorization.where(provider: @auth.provider, uid: @auth.uid.to_s).first

    if @authorization
      if @authorization.confirmed_at.present?
        success_omniauth_sign_in(@authorization.user, @authorization.provider)
      else
        @email = @authorization.user.email
        render 'authorization/unconfirmed'
      end
    else
      create_new_authorization
    end
  end

  # def success_omniauth_sign_in(user, kind)
  #   flash[:notice] = "Successful sign in through #{kind.capitalize}"
  #   set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
  #   sign_in_and_redirect user, event: :authentication
  # end

  def create_new_authorization
    if @auth.info && @auth.info[:email]
      @user = User.from_omniauth(@auth)
      if @user&.persisted?
        success_omniauth_sign_in(@user, @auth.provider)
      else
        redirect_to new_user_registration_url
      end
    else
      flash.now[:notice] = "Successful sign in through #{@auth.provider.capitalize}"
      session[:auth] = { uid: @auth.uid, provider: @auth.provider }
      @authorization = Authorization.new(provider: @auth.provider, uid: @auth.uid.to_s)
      render 'authorization/new'
    end
  end
end
