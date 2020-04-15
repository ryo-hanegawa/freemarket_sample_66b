Rails.application.routes.draw do
  devise_for :users
  root 'top#index'
  resources :items, except: :index
  resources :users, only: [:index, :show]
  resources :creditcards, only: [:index, :new, :create, :destroy]
  resources :logouts, only: :index
  resources :exhibitions, only: [:index, :create]
  resources :purchases,only: [:show]
  resources :products,only: [:index, :show, :edit, :destroy]
end
