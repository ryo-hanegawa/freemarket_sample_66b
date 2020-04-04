Rails.application.routes.draw do
  root 'items#index'
  resources :items, except: :index
  resources :purchases,only: [:show]
  root "purchases#show"
end
