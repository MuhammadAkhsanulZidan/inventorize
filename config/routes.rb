Rails.application.routes.draw do
  #resources :items
  resources :storages
  devise_for :users

  #dashboard
  get ':storage/dashboard' => 'dashboard#index'

  #items
  get ':storage/items' => 'items#index'
  get ':storage/items/:id' => 'items#show'
  get ':storage/items/new' => 'items#new'
  post ':storage/items' => 'items#create'
  get ':storage/items/:id/edit' => 'items#edit'
  put ':storage/items/:id' => 'items#update'
  delete ':storage/items/:id' => 'items#destroy'

  
  # Defines the root path route ("/")
  root "dashboard#index"

end
