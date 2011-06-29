ArtisanEngine::Application.routes.draw do
  root to: 'pages#home'
  
  resources :frames
  
  resources :pages
  post '/page/preview' => 'pages#preview'
  
  resources :users
  resources :images
  
  # Recreate Devise routes from scratch and override Sessions Controller.
  devise_for :users, controllers: { sessions: 'sessions' }, skip: [ :sessions ] do
    get  '/sign_in'  => 'sessions#new',     as: 'new_user_session'
    post '/sign_in'  => 'sessions#create',  as: 'user_session'
    get  '/sign_out' => 'sessions#destroy', as: 'destroy_user_session'
  end
end
