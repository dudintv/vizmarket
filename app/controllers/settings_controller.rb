class SettingsController < ApplicationController
  layout 'settings'
  before_action :authenticate_user!
  
  def index
  end

  def user_data
    render json: UserSerializer.new(current_user).serialized_json
  end

  def update_user
    if current_user.update(user_params)
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

  def update_publisher
  end
  
  def destroy_account_link
  end
  
  def destroy_my_account
  end

  private

  def user_params
    params.require(:user).permit(:name, :surname, :jobtitle, :country, :about, :avatar)
  end
end
