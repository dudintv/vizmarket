class Publisher::AuthorController < ApplicationController
  before_action :authenticate_user!

  def index
    render inline: '<div id="publisher-author-app"></div>', layout: 'publisher-author'
  end

  def new
    render inline: "<div id=\"publisher-start-app\"></div>", layout: 'publisher-start'
  end

  def show
    if current_user.author
      render json: AuthorSerializer.new(current_user.author).serialized_json
    else
      render json: {
        data: {
          attributes: {
            name: current_user.full_name,
            support: {
              email: current_user.email
            },
            private: {
              fullName: current_user.full_name,
              email: current_user.email
            }
          }
        }
      }, status: :ok
    end
  end

  # def create
  #   author = current_user.build_author(author_params)
  #   if author.save
  #     render json: {}, status: :ok
  #   else
  #     render json: author.errors.as_json, status: :unprocessable_entity
  #   end
  # end

  def update
    Author.create(user: current_user, name: author_params[:name]) unless current_user.author.present?
    if current_user.author.update(author_params)
      render json: {}, status: :ok
    else
      render json: author.errors.as_json, status: :unprocessable_entity
    end
  end

  def activate
    if current_user.author.set_as_completed
      render json: {}, status: :ok
    else
      render json: current_user.author.errors.as_json, status: :unprocessable_entity
    end
  end

  private

  def author_params
    params.require(:author).permit(:name, links: {}, support_contacts: {}, private_contacts: {})
  end
end
