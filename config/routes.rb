Rails.application.routes.draw do
  root 'pages#test'

  get 'scripts', to: 'products#scripts'
  get 'scenes', to: 'products#scenes'
  get 'plugins', to: 'products#plugins'
  get 'free', to: 'products#free'
  get 'vault', to: 'products#vault'
  
  # resources :portfolios, only: [:index, :show]
  
  devise_for :admins, controllers: { sessions: "admins/sessions", registrations: 'admins/registrations', passwords: 'admins/passwords' }
  devise_for :users, controllers: { sessions: "users/sessions", registrations: 'users/registrations', passwords: 'users/passwords', omniauth_callbacks: 'users/omniauth_callbacks' }
  get '/users', to: redirect('/')

  resources :authorizations, only: [:new, :create] do
    get 'confirm', on: :member
    post 'resend', on: :member
  end

  get "/profile", to: "profile#index"
  get "/profile/*slug", to: "profile#index"

  namespace :creator do
    resources :products
    get 'edit_settings', to: 'settings#edit'
    post 'update_settings', to: 'settings#update'
  end

  namespace :test do
    get 'colors'
  end
end
