class Publisher::AuthorController < ApplicationController
  before_action :authenticate_user!

  def index
    render inline: '<div id="#publisher-author-app"></div>', layout: 'publisher-author'
  end

  def new
    render inline: '<div id="#publisher-start-app"></div>', layout: 'publisher-start'
  end

  def create
    author = current_user.build_author(author_params)
    if author.save
      render json: {}, status: :ok
    else
      render json: author.errors.as_json, status: :unprocessable_entity
    end
  end

  def update
    if current_user.author.update(author_params)
      render json: {}, status: :ok
    else
      render json: author.errors.as_json, status: :unprocessable_entity
    end
  end

  private

  def author_params
    params.require(:author).permit(:name, :title, :links, :support_contacts, :private_contacts)
  end
end
