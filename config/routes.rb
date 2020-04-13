Rails.application.routes.draw do
  devise_for :users
  root 'top#index'
  resources :items, except: :index
  resources :users, only: :show do
    resources :creditcards, only: [:index, :new, :create, :destroy]
  end
  resources :logouts, only: :index
  resources :exhibitions, only: [:index, :create]
  resources :purchases,only: [:show]
  resources :products,only: [:show]
end
