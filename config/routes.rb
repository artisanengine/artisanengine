ArtisanEngine::Application.routes.draw do
  scope module: 'engine_room' do
    scope path: 'engineer' do
      resources :frames
    end
  end
end
