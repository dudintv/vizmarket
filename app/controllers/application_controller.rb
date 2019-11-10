class ApplicationController < ActionController::Base
  before_action :get_data

  private

  def get_data
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
      ],

      anonses: [
        {
          image: '/images/anons/became-author.jpg',
          title: 'Became an Author',
          text: 'Do you have usefull solutions, like scripts or scene example? Lets share the gems!',
          link: '#',
          action: 'Submit content'
        },
        {
          image: '/images/anons/create-portfolio.jpg',
          title: 'Publish your Vizrt portfolio',
          text: 'Do you want to have a professional portfolio properly describes you as a Vizrt Specialist?',
          link: '#',
          action: 'Create portfolio'
        },
      ],

      products: [
        {
          image: '',
          title: 'Random Movement',
          author: 'Dmitry Dudin',
          version: '1.2',
          date: '03-07-2019',
          price: 10,
          pating: 4.5,
          kind: "Script",
          categories: [
            {title: "position", link: '#'},
          ],
          labels: [
            "Featured",
            "New",
          ]
        },
        {
          image: '',
          title: 'Random Movement',
          author: 'Dmitry Dudin',
          version: '1.2',
          date: '03-07-2019',
          price: 10,
          pating: 4.5,
          kind: "Script",
          categories: [
            {title: "position", link: '#'},
          ],
          labels: [
            "Featured",
            "New",
          ]
        },
        {
          image: '',
          title: 'Random Movement',
          author: 'Dmitry Dudin',
          version: '1.2',
          date: '03-07-2019',
          price: 10,
          pating: 4.5,
          kind: "Script",
          categories: [
            {title: "position", link: '#'},
          ],
          labels: [
            "Featured",
            "New",
          ]
        },
        {
          image: '',
          title: 'Random Movement',
          author: 'Dmitry Dudin',
          version: '1.2',
          date: '03-07-2019',
          price: 10,
          pating: 4.5,
          kind: "Script",
          categories: [
            {title: "position", link: '#'},
          ],
          labels: [
            "Featured",
            "New",
          ]
        },
        {
          image: '',
          title: 'Random Movement',
          author: 'Dmitry Dudin',
          version: '1.2',
          date: '03-07-2019',
          price: 10,
          pating: 4.5,
          kind: "Script",
          categories: [
            {title: "position", link: '#'},
          ],
          labels: [
            "Featured",
            "New",
          ]
        },
        {
          image: '',
          title: 'Random Movement',
          author: 'Dmitry Dudin',
          version: '1.2',
          date: '03-07-2019',
          price: 10,
          pating: 4.5,
          kind: "Script",
          categories: [
            {title: "position", link: '#'},
          ],
          labels: [
            "Featured",
            "New",
          ]
        },
        {
          image: '',
          title: 'Random Movement',
          author: 'Dmitry Dudin',
          version: '1.2',
          date: '03-07-2019',
          price: 10,
          pating: 4.5,
          kind: "Script",
          categories: [
            {title: "position", link: '#'},
          ],
          labels: [
            "Featured",
            "New",
          ]
        },
      ]
    }
  end
end
