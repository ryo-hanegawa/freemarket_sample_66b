Rails.application.routes.draw do
  # root 'users#index'
  root 'users#signup'
  root 'exhibition#index'
  resources :items, except: :index
  resources :exhibitions, only: [:index, :create]
  resources :purchases,only: [:show]
  root "purchases#show"
end
