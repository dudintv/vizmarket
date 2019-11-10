Rails.application.routes.draw do
  root 'pages#test'

  get "/profile", to: "profile#index"
  get "/profile/*slug", to: "profile#index"
end
