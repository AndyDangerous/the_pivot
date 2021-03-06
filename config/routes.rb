Rails.application.routes.draw do

  root to: "static_pages#home"

  resources :categories

  resources :business_users
  resources :customer_users
  resources :users
  resources :listings
  namespace :business_users do
  resources :listings
  end


  resources :sessions, only: [:new, :create, :destroy]

  match "/home",    to: "static_pages#home",    via: "get"
  match "/about",   to: "static_pages#about",   via: "get"
  match "/contact", to: "static_pages#contact", via: "get"

  match "/register", to: "users#new",          via: "get"
  match "/signin",   to: "sessions#new",       via: "get"
  match "/signout",  to: "sessions#destroy",   via: "get"
  match "/dashboard", to: "user#show", via:"get"

  namespace :users do
    resources :orders
    resources :cart_items
  end

  namespace :administrator do
    get "/paid" => "orders#paid", as: :paid
    get "/ordered" => "orders#ordered", as: :ordered
    get "/cancelled" => "orders#cancelled", as: :cancelled
    get "/completed" => "orders#completed", as: :completed
    get "/cancel/:id" => "orders#cancel", as: :cancel
    get "/complete/:id" => "orders#complete", as: :complete
    resources :cart_items
    resources :admins
    resources :items
    resources :categories
    resources :orders
    resources :users
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

end
