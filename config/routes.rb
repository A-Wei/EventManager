Rails.application.routes.draw do
  root 'home#index'

  get '/signup' => 'signup#new'
  post '/signup' => 'signup#create'

  get '/login' => 'sessions#new'
  resources :users, only: [:show]
end
