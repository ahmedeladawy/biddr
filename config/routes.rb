Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :auctions do
    resources :bids, only: :create
    resources :likes, only: [:create, :destroy]
    resources :publishings, only: :create
  end

  resources :users, only: [:new, :create] do
     resources :likes, only: [:index]
  end

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  root 'auctions#index'

end
