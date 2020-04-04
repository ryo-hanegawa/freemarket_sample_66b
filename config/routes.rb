Rails.application.routes.draw do
  devise_for :users
  root 'items#index'
  resources :items, except: :index
  resources :users, only: :show do
    resources :creditcards, only: [:index, :new, :create, :destroy]
  end
  resources :logouts, only: :index
end
