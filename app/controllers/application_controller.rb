class ApplicationController < ActionController::Base
  devise_group :account, contains: [:user, :admin]
  # before_action :authenticate_user!
  before_action :get_data

  private

  # for OmniAuth
  def success_omniauth_sign_in(user, kind)
    flash[:notice] = "Successfully authenticated from #{kind.capitalize}"
    sign_in_and_redirect user, event: :authentication
  end

  #########################################################################
  #TEMP DATA:

  def get_data
    @data = {
      user: current_user,
      # cart_items: [
      #   {
      #       "type": "Script",
      #       "category": "Position",
      #       "title": "Random movements with brilliant accuracy",
      #       "original_price": "$ 50.0",
      #       "price": "$ 12.5"
      #   },{
      #       "type": "Script",
      #       "category": "Position",
      #       "title": "Flex",
      #       "price": "$ 29.0"
      #   },{
      #       "type": "Plugin",
      #       "category": "Position",
      #       "title": "Center array lines",
      #       "original_price": "$ 200.0",
      #       "price": "$ 150.0"
      #   }
      # ],
      socnets: [
        # {
        #   "title": "Google",
        #   "icon": "google",
        #   "link": user_google_omniauth_authorize_path
        # },
        # {
        #   "title": "Facebook",
        #   "icon": "facebook",
        #   "link": user_facebook_omniauth_authorize_path
        # }
      ],

      anonses: [
        {
          image: '/images/anons/became-author.jpg',
          title: 'Become an Author',
          text: 'Do you have usefull solutions, like scripts or scene example? Lets share the gems!',
          link: '#',
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
      ],

      # products: [
      #   {
      #     image: '',
      #     title: 'Random Movement',
      #     author: 'Dmitry Dudin',
      #     version: '1.2',
      #     date: '03-07-2019',
      #     price: 10,
      #     pating: 4.5,
      #     kind: "Script",
      #     categories: [
      #       {title: "position", link: '#'},
      #     ],
      #     labels: [
      #       "Featured",
      #       "New",
      #     ]
      #   },
      #   {
      #     image: '',
      #     title: 'Random Movement',
      #     author: 'Dmitry Dudin',
      #     version: '1.2',
      #     date: '03-07-2019',
      #     price: 10,
      #     pating: 4.5,
      #     kind: "Script",
      #     categories: [
      #       {title: "position", link: '#'},
      #     ],
      #     labels: [
      #       "Featured",
      #       "New",
      #     ]
      #   },
      #   {
      #     image: '',
      #     title: 'Random Movement',
      #     author: 'Dmitry Dudin',
      #     version: '1.2',
      #     date: '03-07-2019',
      #     price: 10,
      #     pating: 4.5,
      #     kind: "Script",
      #     categories: [
      #       {title: "position", link: '#'},
      #     ],
      #     labels: [
      #       "Featured",
      #       "New",
      #     ]
      #   },
      #   {
      #     image: '',
      #     title: 'Random Movement',
      #     author: 'Dmitry Dudin',
      #     version: '1.2',
      #     date: '03-07-2019',
      #     price: 10,
      #     pating: 4.5,
      #     kind: "Script",
      #     categories: [
      #       {title: "position", link: '#'},
      #     ],
      #     labels: [
      #       "Featured",
      #       "New",
      #     ]
      #   },
      #   {
      #     image: '',
      #     title: 'Random Movement',
      #     author: 'Dmitry Dudin',
      #     version: '1.2',
      #     date: '03-07-2019',
      #     price: 10,
      #     pating: 4.5,
      #     kind: "Script",
      #     categories: [
      #       {title: "position", link: '#'},
      #     ],
      #     labels: [
      #       "Featured",
      #       "New",
      #     ]
      #   },
      #   {
      #     image: '',
      #     title: 'Random Movement',
      #     author: 'Dmitry Dudin',
      #     version: '1.2',
      #     date: '03-07-2019',
      #     price: 10,
      #     pating: 4.5,
      #     kind: "Script",
      #     categories: [
      #       {title: "position", link: '#'},
      #     ],
      #     labels: [
      #       "Featured",
      #       "New",
      #     ]
      #   },
      #   {
      #     image: '',
      #     title: 'Random Movement',
      #     author: 'Dmitry Dudin',
      #     version: '1.2',
      #     date: '03-07-2019',
      #     price: 10,
      #     pating: 4.5,
      #     kind: "Script",
      #     categories: [
      #       {title: "position", link: '#'},
      #     ],
      #     labels: [
      #       "Featured",
      #       "New",
      #     ]
      #   },
      # ]
    }
  end
end
