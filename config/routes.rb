Rails.application.routes.draw do
  resources :storages
  devise_for :users

  #dashboard
  get ':storage/dashboard' => 'dashboard#index'

  #items
  get ':storage/items' => 'items#index'
  get ':storage/items/new' => 'items#new'
  get ':storage/items/:id' => 'items#show'
  post ':storage/items' => 'items#create'
  get ':storage/items/:id/edit' => 'items#edit'
  put ':storage/items/:id' => 'items#update'
  delete ':storage/items/:id' => 'items#destroy'

  #sales
  get ':storage/sales' => 'sales#index'
  get ':storage/sales/new' => 'sales#new'
  post ':storage/sales' => 'sales#create'
  get ':storage/sales/:id/edit' => 'sales#edit'
  put ':storage/sales/:id' => 'sales#update'
  get ':storage/search_item', to: 'search#search_item'
  post ':storage/sales/create_sale', to: 'sales#create_sale'

  # Defines the root path route ("/")
  root "dashboard#index"

end
