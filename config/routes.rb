ArtisanEngine::Application.routes.draw do
  root to: 'visit/pages#home'
  
  get '/develop' => 'develop/develop#interface'
  namespace :develop do
    resources :frames
    resources :artisans
  end
  
  get '/manage' => 'manage/manage#interface'
  namespace :manage do
    resources :goods do
      resources :options
      resources :variants
      resources :image_attachers do
        post 'sort', on: :collection
      end
      resources :images
    end
    resources :display_cases do
      resources :collects
    end
    resources :images
    resources :pages
    post      'page/preview' => 'pages#preview', as: 'preview_page'
    resource  :blog do
      resources :posts
    end
    resources :tags
  end
  
  scope :module => :visit do
    resources :pages, only: [ :show ]
    resource  :blog, only: [ :show ] do
      get '/year/:year' => 'posts#index'
      get '/:tag_id'    => 'posts#index'
      resources :posts, only: [ :show ]
    end
    resources :goods, only: [ :show ]
  end
  
  # Recreate Devise routes from scratch and override Sessions Controller.
  devise_for :artisans, controllers: { sessions: 'manage/sessions' }, skip: [ :sessions ] do
    get  '/manage/sign_in'  => 'manage/sessions#new',     as: 'new_artisan_session'
    post '/manage/sign_in'  => 'manage/sessions#create',  as: 'artisan_session'
    get  '/manage/sign_out' => 'manage/sessions#destroy', as: 'destroy_artisan_session'
  end
  
  devise_for :engineers, controllers: { sessions: 'develop/sessions' }, skip: [ :sessions ] do
    get  '/develop/sign_in'  => 'develop/sessions#new',     as: 'new_engineer_session'
    post '/develop/sign_in'  => 'develop/sessions#create',  as: 'engineer_session'
    get  '/develop/sign_out' => 'develop/sessions#destroy', as: 'destroy_engineer_session'
  end
end
