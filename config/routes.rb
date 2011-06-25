ArtisanEngine::Application.routes.draw do
  root to: 'users#new'
  
  resources :frames
  resources :pages
  resources :users
  
  # Recreate Devise routes from scratch.
  devise_for :users, skip: [ :sessions ] do
    get  '/sign_in'  => 'devise/sessions#new',     as: 'new_user_session'
    post '/sign_in'  => 'devise/sessions#create',  as: 'user_session'
    get  '/sign_out' => 'devise/sessions#destroy', as: 'destroy_user_session'
  end
end
