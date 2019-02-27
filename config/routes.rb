Rails.application.routes.draw do
  root 'home#index'

  get '/signup' => 'signup#new'
  post '/signup' => 'signup#create'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  resource :search, only: [:create]
  resources :events, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :reset_password, only: [:new, :create, :show, :edit, :update]
  resources :users, only: [:show, :edit, :update]
end
