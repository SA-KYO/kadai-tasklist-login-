Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'

 
  get 'users/new'
  get 'users/create'

  get 'signup', to: 'users#new'

  get 'login',     to: 'sessions#new'
  post 'login',    to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  root to: 'tasks#index'

  resources :tasks
  resources :users, only: [:new, :create]
end