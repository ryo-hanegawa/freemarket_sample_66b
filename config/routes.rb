Rails.application.routes.draw do
  root 'items#index'
  resources :items, except: :index
  get 'purchases/show'
  root "purchases#show"
end
