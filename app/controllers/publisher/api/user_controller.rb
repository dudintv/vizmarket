class Publisher::Api::UserController < ApplicationController
  before_action :authenticate_user!
  
  def show
    render json: UserSerializer.new(current_user).serialized_json
  end
end
