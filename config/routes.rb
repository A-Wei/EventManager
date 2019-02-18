Rails.application.routes.draw do
  root 'home#index'

  get '/signup' => 'signup#new'
  post '/signup' => 'signup#create'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  resources :password_reset, only: [:new, :create, :show, :edit, :update]
  resources :users, only: [:show, :edit, :update]
end
