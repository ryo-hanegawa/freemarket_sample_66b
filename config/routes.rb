Rails.application.routes.draw do
  root 'top#index'
  resources :items, except: :index
  resources :exhibitions, only: [:index, :create]
  resources :purchases,only: [:show]
end
