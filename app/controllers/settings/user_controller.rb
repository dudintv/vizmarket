class Settings::UserController < ApplicationController
  before_action :authenticate_user!

  def index
    render inline: '<div id="settings-user-app"></div>', layout: 'settings-user'
  end

  def show
    render json: UserSerializer.new(current_user).serialized_json
  end

  def update
    if current_user.update(user_params)
      render json: {}, status: :ok
    else
      render json: current_user.errors.as_json, status: :unprocessable_entity
    end
  end

  def reset_password
    if current_user.send_reset_password_instructions
      render json: {}, status: :ok
    else
      render json: current_user.errors.as_json, status: :unprocessable_entity
    end
  end

  def update_password
    unless params[:user][:current_password].present? && current_user.valid_password?(params[:user][:current_password])
      render json: current_user.errors.as_json, status: :unauthorized
      return
    end
    new_pass = params[:user][:new_password]
    if current_user.reset_password(new_pass, new_pass)
      current_user.save
      render json: {}, status: :ok
    else
      render json: current_user.errors.as_json, status: :unprocessable_entity
    end
  end

  def upload_avatar
    if params[:avatar]
      if current_user.update(avatar: params[:avatar])
        render json: { avatar: current_user.avatar }, status: :ok
      else
        render json: current_user.errors.as_json, status: :unprocessable_entity
      end
    end
  end

  def delete_avatar
    current_user.avatar.purge
    render json: {}, status: :ok
  end

  def destroy_account_link
    p "!!!! params = " + params.to_s
    p "!!!! params[:account] = " + params[:account].to_s
    p "!!!! current_user.authorizations.where(provider: params[:account]).first = " + current_user.authorizations.where(provider: params[:account]).first.to_s
    if current_user.authorizations.where(provider: params[:account]).first&.destroy
      render json: {}, status: :ok
    else
      render json: {}, status: :not_found
    end
  end

  def destroy_my_account
    if current_user.update(deleted_at: Time.zone.now)
      sign_out
      flash[:notice] = "Successfully delete account. Good bye!"
      redirect_to root_path
    else
      render json: current_password.errors.as_json, status: :unprocessable_entity
    end
  end

  def get_invitations_list
    invitations = current_user.invitations
    render json: { invitations: invitations }, status: :ok
  end

  def create_invitations
    new_invitations = []
    3.times do
      new_invitations.push(current_user.invitations.create)
    end
    if new_invitations
      render json: { invitations: new_invitations }, status: :ok
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :surname, :jobtitle, :country, :about)
  end
end
