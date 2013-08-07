UnifiApp::Application.routes.draw do

  resources :friendships do
      get '/friend/:id', to: "friendships#new_friend", on: :collection, as: :new_friend
    end

  resources :sharing_preferences

  resources :user_networks

  resources :wifi_networks

  # resources :users do
  #   get "/friendships", as: :friendships, on: :member, action: "friendship"
  # end

  root to: "user_networks#index"

  devise_for :users, :controllers => { registrations: :registrations }
  get '/users', to: "users#index", as: 'users'
  get '/users/:id', to: "users#show", as: 'user'
  post '/users/:id/friend_add_relationship', to: "users#friend_add_relationship", as: :friend_add_relationship
  post '/users/:id/friend_confirm_relationship', to: "users#friend_confirm_relationship", as: :friend_confirm_relationship
  post '/users/:id/friend_update_relationship', to: "users#friend_update_relationship", as: :friend_update_relationship
  get '/users/:id/add_friend', to: "users#new_friend", as: :new_friend
  get '/users/:id/confirm_friend', to: "users#confirm_friend", as: :confirm_friend
  get '/users/:id/update_friend', to: "users#update_friend", as: :update_friend
  get '/users/:id/deny_friend', to: "users#deny_friend", as: :deny_friend
  get '/users/:id/defriend', to: "users#defriend", as: :defriend



  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
