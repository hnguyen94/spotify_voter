Rails.application.routes.draw do
  get 'tracks/', to: 'tracks#index'

  get 'home/index'
  root 'home#index'

  get '/auth/:provider/callback' => 'sessions#create'
  get '/auth/failure' => 'sessions#failure'
  get '/signout' => 'sessions#destroy', :as => :signout
  # root to: redirect('/auth/spotify') # for convenience

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
