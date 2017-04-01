Rails.application.routes.draw do

  get '/user/:user_id/playlists' => 'playlists#index'

  get '/playlist' => 'playlists#show'


  get 'tracks/' => 'tracks#index'
  put 'tracks/:id' => 'tracks#update'
  post 'tracks/' => 'tracks#create'
  put 'check-last-track' => 'tracks#check_last_played_track'


  get 'home/index'
  root 'home#index'



  get '/auth/:provider/callback' => 'sessions#create'
  get '/auth/failure' => 'sessions#failure'
  get '/signout' => 'sessions#destroy', :as => :signout
  # root to: redirect('/auth/spotify') # for convenience

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
