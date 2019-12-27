Rails.application.routes.draw do
  root 'pages#test'
  
  devise_for :admins
  devise_for :users

  get "/profile", to: "profile#index"
  get "/profile/*slug", to: "profile#index"
end
