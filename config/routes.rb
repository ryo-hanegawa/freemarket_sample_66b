Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
  }
  root 'top#index'

  devise_scope :user do
    get   'addresses', to: 'users/registrations#new_address'
    post  'addresses', to: 'users/registrations#create_address'
  end
  resources :signup do
    collection do
      get 'done' #【新規会員登録】完了ページへ移動
    end
  end

  resources :users, only: [:index, :show] do
    resources :creditcards, only: [:new, :show] do
      collection do
        post 'show', to: 'creditcards#show'
        post 'pay', to: 'creditcards#pay'
        post 'delete', to: 'creditcards#delete'
      end
    end
  end
  
  resources :purchases,only: [:show] do
    collection do
      get 'show', to: 'purchase#index'
      post 'pay', to: 'purchase#pay'
      get 'done', to: 'purchase#done'
    end
  end
  
  resources :top, except: :index
  resources :logouts, only: :index
  resources :items, except: :show
  resources :products,only: [:index, :show, :edit, :destroy, :update]

end
