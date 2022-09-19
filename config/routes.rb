Rails.application.routes.draw do
  get 'orders/complete'
  get 'customers/my_page' => 'customers#show'
  get 'customers/information/edit' => 'customers#edit'
  patch 'customers/information' => 'customers#update'
  get 'customers/unsubscribe' => 'customers#unsubscribe'
  patch 'customers/withdraw' => 'customers#withdraw'
  namespace :admin do
    resources :orders, only: [:show]
  end
  namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update]
  end
  namespace :admin do
    resources :genres, only: [:index, :create, :edit, :update]
  end
  namespace :admin do
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
  end
  namespace :admin do
    get 'homes/top'
  end
  delete 'cart_items/destroy_all' => 'cart_items#destroy_all'
  resources :cart_items, only: [:index, :create, :update, :destroy]
  resources :orders, only: [:new, :create, :index, :show] do
    collection do
      post :confirm
    end
  end
  resources :addresses, only: [:index, :create, :edit, :destroy, :update]
  resources :items, only: [:index, :show]
  root to: "homes#top"
  get 'homes/about'
  devise_for :customers
  devise_for :admins
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
