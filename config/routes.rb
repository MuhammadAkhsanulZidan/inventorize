Rails.application.routes.draw do
  resources :items
  resources :storages
  devise_for :users
  # Defines the root path route ("/")
  root "storages#index"
end
