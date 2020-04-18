Rails.application.routes.draw do

  resources :items, except: :show
  resources :purchases,only: [:show]
end
