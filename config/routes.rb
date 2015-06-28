Rails.application.routes.draw do

  get 'ajax/dispatch' => 'ajax#dispatch_action'

  get 'sessions/login'

  get 'sessions/denied'

  get 'sessions/logout'
  
  get 'sessions/home'

  get 'sessions/profile'

  get 'sessions/setting'

  post 'sessions/login_attempt'

  get 'users/new'

  post 'users/create'
  
  get 'workstreams/new'

  get 'workstreams/create'

  get 'workstreams/update'

  get 'workstreams/edit'

  get 'workstreams/destroy'

  get 'workstreams/show'

  get 'workstreams/index'

  get 'goals/:id/complete' => 'goals#complete'
  
  get 'api/workstreams/:id' => 'workstream_api#fetch'

  get 'api/workstreams/:id/goaltable' => 'goals#api_table', as: :api_goal_table

  # get 'home/index'
  root 'home#index'

  resources :workstreams do
    resources :goals
  end

  resources :projects, :controller => "workstreams", :type => "Project"

  resources :goals
  
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
