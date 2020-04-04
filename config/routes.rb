Rails.application.routes.draw do

  root 'exhibition#index'
  resources :items, except: :index
  resources :exhibitions, only: [:index, :create]
end
