Rails.application.routes.draw do
  root to: "static_pages#home"
  get 'signup', to: 'users#new'
  get 'login' , to: 'sessions#new'
  post 'login' , to: 'sessions#create'
  delete 'logout' , to: 'sessions#destroy'
  
  resources :users
  resources :microposts
  post 'retweet', to: 'microposts#retweet'
  resources :relationships, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]
  resources :users do 
    member do
      get 'followings', 'followers', 'favorites', 'retweets'
    end
  end
end
