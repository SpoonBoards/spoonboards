Rails.application.routes.draw do

  resources :receipts
  resources :cart_items
  resources :carts
  root 'sessions#new'

  get '/auth/:provider/callback' => 'sessions#create'
  get '/auth/failure' => 'sessions#new'
  get 'login' => 'sessions#new'
  get 'show' => 'sessions#show'
  post 'create' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  get 'logout' => 'sessions#destroy'

  post 'boards/show'

  get 'boards/pinterest_board_create'
  post 'boards/clone_board'


  post 'cart_items/add_entire_board'
  post 'cart_items/add_to_cart'
  post 'searches/index'
  get 'designs/index'
  get 'designs/show'
  get 'searches/search'
  post 'charges/index'
  post 'charges/new'

  resources :designs
  resources :users
  resources :boards
  resources :sessions
  resources :searches
  resources :charges
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
