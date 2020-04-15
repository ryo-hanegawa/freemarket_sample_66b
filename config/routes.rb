Rails.application.routes.draw do
  devise_for :users
  root 'top#index'
  resources :top, except: :index
  resources :items, except: :index
  resources :users, only: [:index, :show] do
  resources :creditcards, only: [:index, :new, :create, :destroy]
  end
  
  resources :logouts, only: :index
  resources :exhibitions, only: [:index, :create]
  resources :purchases,only: [:show]
  resources :products,only: [:index, :show, :edit, :destroy]
end
