Rails.application.routes.draw do

  #get '/users', to: "channels#index_users"

  concern :tracks do
    resources :tracks, only: [:index]
  end
  resources :tags, concerns: :tracks, only: [:index, :show]
  resources :channels, concerns: :tracks, only: [:index, :show]
  resources :users, concerns: :tracks, only: [:index, :show]
  resources :tracks, only: [:index, :show]

  root to: 'tracks#index'
end
