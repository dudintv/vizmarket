class SettingsController < ApplicationController
  layout 'settings'
  before_action :authenticate_user!

  def edit
  end

  def update
    render :edit
  end
end
