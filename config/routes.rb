Rails.application.routes.draw do
  root 'items#index'
  resources :items, only: :index

  root "products#show"
  resources :products, only: [:show]

  root "purchases#show"
  resources :purchases, only: [:show]


end
