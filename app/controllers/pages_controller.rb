class PagesController < ApplicationController
  def index
    @anonses = [
      {
        image: '/images/anons/became-author.jpg',
        title: 'Became an Author',
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
        link: '#',
        action: 'How to install a script?'
      },
    ]
    @products = Product.all.with_attached_thumbnail
  end

  def test
  end
end
