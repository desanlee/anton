Anton::Application.routes.draw do

  get "home/index"
  root to: "home#index"

  devise_for :users

  match '/help',    to: 'static_pages#help'
  match '/about',   to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact' 
  
  resources :devicetypes
  resources :devices
  
  match '/devices/', to: 'devices#index'
  post '/devices/selectcate'
  post '/devices/selecttype'
  post '/devices/addtype'
  post '/devices/adddevice'
  
  resources :systems
  resources :avlrelationships
 
  match '/systems/', to: 'systems#index'
  post '/systems/selectcate'
  post '/systems/selectsystem'
  post '/systems/selecttype'
  post '/systems/addsystem'
  post '/systems/adddevice'   
  
  resources :casetypes
  resources :testcases
  
  match '/testcases/', to: 'testcases#index'
  post '/testcases/selectcate'
  post '/testcases/selecttype'
  post '/testcases/addtype'
  post '/testcases/addcase'
  
  resources :suts
  resources :sysconfigrelationships
  resources :sysconfigs
  
  match '/sysconfigs/', to: 'sysconfigs#index'
  post '/sysconfigs/selectsut'
  post '/sysconfigs/selecttype'
  post '/sysconfigs/addsut'
  post '/sysconfigs/adddevice'
  post '/sysconfigs/newconfig'
  post '/sysconfigs/selectuser'
  
  resources :executions
  
  match '/executions/', to: 'executions#index'
  post '/executions/selectsut'
  post '/executions/selectcate'
  post '/executions/selecttype'
  post '/executions/selectcase'
  post '/executions/addcase'
  
  resources :priviledges
  
  match '/priviledges/', to: 'priviledges#index'
  post '/priviledges/selectuser'
  post '/priviledges/addcharactor'
  
  match '/achivements/', to: 'achivements#index'
  
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
