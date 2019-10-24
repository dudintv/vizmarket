class PagesController < ApplicationController
  def home
  end

  def test
    @data = {
      menu: [
        "Scripts",
        "Scenes",
        "Plugins",
        "Free",
        "Portfolios",
        "Vault"
      ],
      user: {
        "name": "Dmitry",
        "surname": "Dudin",
        "email": "svetoz@gmail.com"
      },
      cart_items: [
        {
            "type": "Script",
            "category": "Position",
            "title": "Random movements with brilliant accuracy",
            "original_price": "$ 50.0",
            "price": "$ 12.5"
        },{
            "type": "Script",
            "category": "Position",
            "title": "Flex",
            "price": "$ 29.0"
        },{
            "type": "Plugin",
            "category": "Position",
            "title": "Center array lines",
            "original_price": "$ 200.0",
            "price": "$ 150.0"
        }
      ],
      socnets: [
        {
            "title": "Google",
            "icon": "google"
        },{
            "title": "Facebook",
            "icon": "facebook"
        },{
            "title": "LinkedIn",
            "icon": "linkedin"
        },{
            "title": "Github",
            "icon": "github"
        },{
            "title": "Twitter",
            "icon": "twitter"
        }
      ]
    }
  end
end
