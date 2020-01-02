Rails.application.routes.draw do
  root 'pages#test'
  
  devise_for :admins, controllers: { sessions: "admins/sessions", registrations: 'admins/registrations', passwords: 'admins/passwords' }
  devise_for :users, controllers: { sessions: "users/sessions", registrations: 'users/registrations', passwords: 'users/passwords', omniauth_callbacks: 'users/omniauth_callbacks' }
  get '/users', to: 'pages#test'

  resources :authorizations, only: [:new, :create] do
    get 'confirm', on: :member
    post 'resend', on: :member
  end

  get "/profile", to: "profile#index"
  get "/profile/*slug", to: "profile#index"
end
