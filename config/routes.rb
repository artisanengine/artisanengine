ArtisanEngine::Application.routes.draw do
  root to: 'visit/pages#home'
  
  get '/develop' => 'develop/develop#interface'
  namespace :develop do
    resources :frames do
      resources :settings
    end
    resources :artisans
  end
  
  get '/manage' => 'manage/manage#interface'
  namespace :manage do
    resources :goods do
      resources :options
      resources :variants
      resources :image_attachers
      resources :images
    end
    resources :display_cases do
      resources :collects
    end
    resources :page_collections do
      resources :page_collects
    end
    resources :images do
      get 'cropping/:priority' => 'images#crop', as: 'cropping'
    end
    resources :pages
    post      'page/preview' => 'pages#preview', as: 'preview_page'
    resource  :blog do
      resources :posts
    end
    resources :tags
    resources :orders do
      resources :fulfillments
    end
    resources :patrons
    resources :promotions
  end
  
  scope :module => :visit do
    resources :pages, only: [ :show ]
    resources :page_collections, only: [ :show ]
    
    resource  :blog, only: [ :show ] do
      resources :posts, only: [ :index ]
      get '/:year(/:month)' => 'posts#index', as: 'by_date'
    end
    get '/blog/:year/:month/:id' => 'posts#show',  as: 'blog_post'
    
    resources :goods, only: [ :show ]
    resources :display_cases, path: 'collections'
    
    post '/subscribe' => 'patrons#subscribe'
    post '/donations' => 'mail_forms#donations'
    post '/press'     => 'mail_forms#press'
    post '/wholesale' => 'mail_forms#wholesale'
    post '/contact'   => 'mail_forms#contact'
    
    post '/apply_promotion' => 'promotions#apply', as: 'apply_promotion'
    
    get '/order'     => 'orders#new',    as: 'new_order'
    get '/checkout'  => 'orders#edit',   as: 'checkout'
    put '/checkout'  => 'orders#update',  as: 'checkout'
    get '/order/confirm' => 'orders#confirm', as: 'confirm'
    get '/order/cancel'  => 'orders#cancel',  as: 'cancel'
    get  '/paypal'   => 'orders#paypal',           as: 'paypal'
    post '/ipns'     => 'order_transactions#ipns', as: 'ipns'
    
    get '/update_state_select' => 'orders#update_state_select', as: 'update_state_select'
    
    resources :line_items do
      post 'update_quantities', on: :collection, as: 'quantities'
    end
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
