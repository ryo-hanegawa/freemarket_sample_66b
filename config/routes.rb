Rails.application.routes.draw do
devise_for :users
root 'top#index'
resources :top, except: :index
resources :items, except: :show
resources :users, only: [:index, :show] do
  resources :creditcards, only: [:index, :new, :create, :destroy]
end

resources :logouts, only: :index
resources :items, except: :show
resources :purchases,only: [:show]
  resources :products,only: [:index, :show, :edit, :destroy]

end
