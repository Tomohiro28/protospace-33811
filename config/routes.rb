Rails.application.routes.draw do
  devise_for :users
  get 'prototypes/index'
  # patch 'prototypes#update'
  # get '/prototypes/:id', to: ' prototypes#show'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "prototypes#index"

  resources :prototypes do
    resources :comments, only: :create
  end
  resources :users, only: :show
 
end
