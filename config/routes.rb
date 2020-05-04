Rails.application.routes.draw do
  devise_for :users, controllers: {
    # sessions: 'users/sessions',
    registrations: "users/registrations",
    # omniauth_callbacks: 'users/omniauth_callbacks'
  }
  root 'top#index'

  devise_scope :user do
    get   'addresses', to: 'users/registrations#new_address'
    post  'addresses', to: 'users/registrations#create_address'
  end
  resources :signup do
    collection do
  #     get 'index' #新規会員登録ページTOPへ移動
  #     get 'step3' #【新規会員登録】住所入力ページへ移動
  #     # get 'step4' #【新規会員登録】支払い方法登録ページへ移動
      get 'done' #【新規会員登録】完了ページへ移動
    end
  end


  # resources :addresses,only:[:create]
    # get '/addresses/new', to: 'addresses#step3'
  resources :users, only: [:index, :show] do
    resources :creditcards, only: [:index, :new, :create, :destroy]
  end
  
  resources :purchases,only: [:show]
  resources :top, except: :index

  resources :users, only: [:index, :show] do
    resources :creditcards, only: [:index, :new, :create, :destroy]
  end

  resources :logouts, only: :index
  resources :items, except: :show
  resources :products,only: [:index, :show, :edit, :destroy]

end
