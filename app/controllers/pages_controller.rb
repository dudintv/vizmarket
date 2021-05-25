require 'pushover'

class PagesController < ApplicationController
  def index
    @anonses = [
      {
        image: '/images/anons/became-author.jpg',
        title: 'Become an Author',
        text: 'Do you have usefull solutions, like scripts or scenes? Lets share your gems!',
        link: '/publisher/index',
        action: 'Submit content'
      },
      # {
      #   image: '/images/anons/create-portfolio.jpg',
      #   title: 'Publish your Vizrt portfolio',
      #   text: 'Do you want to have a professional portfolio properly describes you as a Vizrt Specialist?',
      #   link: '#',
      #   action: 'Create portfolio'
      # },
      {
        image: '/images/anons/learn-basic.jpg',
        title: 'VizScript is easy!',
        text: 'Instructions for VizScript\'s beginners. If you are using a script in the first time.',
        link: '/how-to-install-scripts',
        action: 'How to install a script?'
      },
    ]
    @products = Product.published.with_attached_thumbnail.limit(15)
  end

  def search
    @search_results = PgSearch.multisearch(params["q"])
    @products_ids = @search_results.filter{ |res| res.searchable_type == 'Product' }.map(&:searchable_id)
    @products = Product.find(@products_ids)
  end

  def invitation
  end

  def use_invitation
    invitation = Invitation.find_by(code: params[:code])
    if invitation
      if invitation.active
        invitation.update(active: false)
        redirect_to new_user_registration_url
      else
        flash[:alert] = 'This invitation was already used :('
        redirect_to invitation_url
      end
    else
      flash[:alert] = 'Can not find this invitation :('
      redirect_to invitation_url
    end
  end

  def faq
  end

  def how_to_install_scripts
  end

  def privacy
  end

  def terms
  end

  def contact
  end

  def guidelines
  end

  def test
  end
end
