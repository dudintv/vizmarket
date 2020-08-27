class Publisher::ProductsController < ApplicationController
  layout 'publisher'
  before_action :authenticate_user!

  def index
    unless current_user.is_author?
      flash[:notice] = 'Before, you need to register as a publisher'
      redirect_to publisher_author_start_path
    end
  end
end
