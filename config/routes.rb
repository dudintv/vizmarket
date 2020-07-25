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

  namespace :publisher do
    root to: 'products#index'
    get 'index', to: 'products#index'
    get 'products/*path', to: 'products#index' # to vue-router
    
    get  'settings', to: 'settings#edit'
    post 'settings', to: 'settings#update'

    namespace :api, defaults: { format: :json } do
      constraints ->(r) { r.format == :json } do
        resources :products, only: %i[index show new create update destroy] do
          member do
            post :publish
            post :unpublish
            post :upload_thumbnail
            post :upload_featured_image
            post :upload_gallery_images
            delete :delete_thumbnail
            delete :delete_featured_image
          end
          collection do
            delete :delete_image
          end
          resources :versions, only: %i[index show create update destroy] do
            post :publish, on: :member
            post :unpublish, on: :member
            member do
              post :upload_files
              post :delete_file
            end
          end
        end
      end
    end
  end

  get '/test', to: 'test#test'
  get '/test/images', to: 'test#images' # to test vue-router
  get '/test/*path', to: 'test#test' # to test vue-router
end
