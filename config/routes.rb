Rails.application.routes.draw do
  root 'pages#test'
  
  devise_for :admins, controllers: { sessions: "admins/sessions" }
  devise_for :users, controllers: { sessions: "users/sessions" }

  get "/profile", to: "profile#index"
  get "/profile/*slug", to: "profile#index"
end
