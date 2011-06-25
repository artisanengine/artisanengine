ArtisanEngine::Application.routes.draw do
  root to: 'user_sessions#new'
  
  resources :frames
  resources :pages
  resources :users
  resources :user_sessions
  
  get '/sign_in'  => 'user_sessions#new'
  get '/sign_out' => 'user_sessions#destroy'
end
