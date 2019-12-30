Rails.application.routes.draw do
  root 'pages#test'
  
  devise_for :admins, controllers: { sessions: "admins/sessions", registrations: 'admins/registrations', passwords: 'admins/passwords' }
  devise_for :users, controllers: { sessions: "users/sessions", registrations: 'users/registrations', passwords: 'users/passwords' }
  get '/users', to: 'pages#test'

  get "/profile", to: "profile#index"
  get "/profile/*slug", to: "profile#index"
end
