Rails.application.routes.draw do

  root 'static_pages#home'

  get 'users/new'

  get 'users/edit'

  get 'users/show'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users
end
