Rails.application.routes.draw do
  
  # Routes for main resources
  resources :schools
  resources :users
  resources :orders
  resources :items
  resources :purchases
  resources :item_prices
  resources :sessions

  # Authentication routes
  get 'user/edit' => 'users#edit', as: :edit_current_user
  get 'signup' => 'users#new', as: :signup
  get 'logout' => 'sessions#destroy', as: :logout
  get 'login' => 'sessions#new', as: :login

  # Semi-static page routes
  get 'home' => 'home#home', as: :home
  get 'about' => 'home#about', as: :about
  get 'contact' => 'home#contact', as: :contact
  get 'privacy' => 'home#privacy', as: :privacy
  get 'howto' => 'home#howto', as: :howto

  #dashboard routes
  get 'dashboard' => 'dashboard#dashboard', as: :dashboard
  patch 'ship/:id' => 'dashboard#ship', as: :ship

  #cart routes
  patch 'remove/:id' => 'cart#remove', as: :remove_from_cart
  get 'destroy' => 'cart#destroy', as: :destroy_cart
  get 'add/:id' => 'cart#add', as: :add_to_cart
  get 'get' => 'cart#get', as: :get_cart
  get 'checkout' => 'cart#checkout', as: :checkout
  get 'new' => 'cart#new', as: :new_cart
  
  # Set the root url
  root :to => 'dashboard#dashboard'  

end
