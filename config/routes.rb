Rails.application.routes.draw do
  root to: "top#index"
  devise_for :users, 
  controllers: {
    sessions: 'users/sessions',
    registrations: "users/registrations",
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  resources :signup do
    collection do
      get 'index' #新規会員登録ページTOPへ移動
      get 'step3' #【新規会員登録】住所入力ページへ移動
      get 'step4' #【新規会員登録】支払い方法登録ページへ移動
      get 'done' #【新規会員登録】完了ページへ移動
    end
  end

  devise_scope :user do
    get    'users/signup/registration',   to: 'users/registrations#step1'
    get    'users/signup/sms_confirmation',      to: 'users/registrations#step2'
  end

  resources :items, except: :index
  resources :addresses,only:[:create]
    get '/addresses/new', to: 'addresses#step3'
  resources :users, only: [:index, :show] do
  resources :creditcards, only: [:index, :new, :create, :destroy]
  end
  
  resources :logouts, only: [:index]
  resources :exhibitions, only: [:index, :create]
  resources :purchases,only: [:show]
  resources :products,only: [:index, :show, :edit, :destroy]
end
