Rails.application.routes.draw do

  namespace :admin do
    resources :orders, only: [:show, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    root 'homes#top'
  end

  get 'homes/about' => 'public/homes#about'

  #resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  get '/addresses' => 'public/addresses#index'
  get '/addresses/:id/edit' => 'public/addresses#edit', as: 'edit_address'
  post 'addresses' => 'public/addresses#create'
  patch 'addresses/:id' => 'public/addresses#update', as: 'update_address'
  delete 'addresses/:id' => 'public/addresses#destroy', as: 'destroy_address'

  get 'orders/new' => 'public/orders#new', as: 'new_order'
  post 'orders' => 'public/orders#create', as: 'creat_orders'
  get 'orders' => 'public/orders#index', as: 'orders'
  get 'orders/complete' => 'public/orders#complete'
  get 'orders/:id' => 'public/orders#show', as: 'order'
  resources :orders do
    scope module: :public do
      collection do
       post :confirm
      end
    end
  end
  #resources :cart_items, only: [:index, :update, :destroy, :create]

  get 'cart_items' => 'public/cart_items#index'
  patch 'cart_items/:id' => 'public/cart_items#update', as: 'update_cart_items'
  delete 'cart_items/destroy_all' => 'public/cart_items#destroy_all', as: 'destroy_all_cart_items'
  delete 'cart_items/:id' => 'public/cart_items#destroy', as: 'destroy_cart_item'
  post 'cart_items' => 'public/cart_items#create', as: 'create_cart_items'

  get 'customers/my_page' => 'public/customers#show'
  get 'customers/information/edit' => 'public/customers#edit'
  patch 'customers/information' => 'public/customers#update'
  get 'customers/unsubscribe' => 'public/customers#unsubscribe'
  patch 'customers/withdraw' => 'public/customers#withdraw'

  # resources :items, only: [:index, :show]
  get 'items' => 'public/items#index'
  get 'items/:id' => 'public/items#show', as: 'item'


  devise_for :admins, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  root "public/homes#top"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
