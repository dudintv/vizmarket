class SettingsController < ApplicationController
  layout 'settings'
  before_action :authenticate_user!
  
  def index
  end

  def user_data
    render json: UserSerializer.new(current_user).serialized_json
  end

  def update_user
  end

  def update_password
  end

  def update_publisher
  end
  
  def destroy_account_link
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :surname, :jobtitle, :country, :about, :avatar)
  end
end
