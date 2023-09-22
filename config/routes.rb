Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :users, only: [:show]
  resources :teams, only: [:show]
  resources :transactions, only: [:show, :create, :index]
  resources :wallets, only: [:show, :index]

  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
end
