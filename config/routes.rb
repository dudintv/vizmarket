Rails.application.routes.draw do
  root 'pages#index'

  resources :products, only: [:index, :show]
  resources :authors, only: [:show]
  get 'scripts', to: 'products#scripts'
  get 'shaders', to: 'products#shaders'
  get 'scenes', to: 'products#scenes'
  get 'plugins', to: 'products#plugins'
  get 'tutorials', to: 'products#tutorials'

  get 'categories/:title', to: 'categories#show', as: 'category'
  
  devise_for :admins, controllers: { sessions: "admins/sessions", registrations: 'admins/registrations', passwords: 'admins/passwords' }
  devise_for :users, controllers: { sessions: "users/sessions", registrations: 'users/registrations', passwords: 'users/passwords', omniauth_callbacks: 'users/omniauth_callbacks' }
  get '/users', to: redirect('/')

  resources :authorizations, only: [:new, :create] do
    get 'confirm', on: :member
    post 'resend', on: :member
  end

  # PUBLISHER
  namespace :publisher do
    root to: 'products#index'
    get 'index', to: 'products#index'
    get 'products/*path', to: 'products#index' # to vue-router
    
    namespace :api, defaults: { format: :json } do
      constraints ->(r) { r.format == :json } do
        get 'current_user', to: 'user#show'

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
          resources :versions, only: %i[index show create update destroy], shallow: true do
            member do
              post :publish
              post :unpublish
              post :upload_files
              delete :delete_file
            end
          end
        end
      end
    end

    # get 'author', to: 'author#index', format: :json
    get 'author/show', to: 'author#show', format: :json
    get 'author/start', to: 'author#new' # START TO BE A PUBLISHER
    get 'author/start/*path', to: 'author#new' # START TO BE A PUBLISHER
    get 'author/edit', to: 'author#edit'
    post 'author/update', to: 'author#update', format: :json
    post 'author/activate', to: 'author#activate', format: :json
    get 'author/*path', to: 'author#index' # to vue-router
  end
  
  # SETTINGS
  namespace :settings do
    root to: 'user#index'
    
    get 'user/show', to: 'user#show', format: :json
    post 'user/update', to: 'user#update', format: :json
    post 'user/reset_password', to: 'user#reset_password', format: :json
    post 'user/update_password', to: 'user#update_password', format: :json
    post 'user/upload_avatar', to: 'user#upload_avatar', format: :json
    delete 'user/delete_avatar', to: 'user#delete_avatar', format: :json
    delete 'user/destroy_account_link', to: 'user#destroy_account_link', format: :json
    delete 'user/destroy_my_account', to: 'user#destroy_my_account'
    get 'user/*path', to: 'user#index' # to vue-router
  end
  
  # FOOTER LIKS
  get '/faq', to: 'pages#faq'
  get '/how-to-install-scripts', to: 'pages#how_to_install_scripts'
  get '/privacy', to: 'pages#privacy'
  get '/terms', to: 'pages#terms'
  get '/contact', to: 'pages#contact'
  
  # TEST
  get '/test', to: 'test#test'
  get '/test/images', to: 'test#images'
  get '/test/index', to: 'test#index'
  get '/test/*path', to: 'test#test' # to test vue-router
end
