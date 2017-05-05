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

  get 'dashboard' => 'dashboard#dashboard', as: :dashboard
  patch 'ship/:id' => 'dashboard#ship', as: :ship
  
  # Set the root url
  root :to => 'dashboard#dashboard'  

end
