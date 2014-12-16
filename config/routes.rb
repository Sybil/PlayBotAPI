Rails.application.routes.draw do

  constraints subdomain: 'api' do
    get '/users', to: "channels#index_users"

    concern :tracks do
      resources :musics, only: [:index]
    end
    resources :tags, concerns: :tracks, only: [:index, :show]
    resources :channels, concerns: :tracks, only: [:index, :show]
    resources :users, concerns: :tracks, only: [:index, :show]

    root to: 'musics#index'
  end

end
