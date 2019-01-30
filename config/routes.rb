Rails.application.routes.draw do
  root 'home#index'

  get '/sign_up' => 'users#new'
  post '/sign_up' => 'users#create'

  resources :users, only: [:show]
end
