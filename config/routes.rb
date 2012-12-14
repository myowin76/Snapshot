Snapshot::Application.routes.draw do
  resources :brand_owners

  resources :user_types

  resources :save_searches

  resources :subscriptions

  resources :locations

  resources :themes

  resources :promotion_calendars

  resources :promotion_types

  devise_for :users
  
  resources :photos do
    collection do
      put :publish_multiple
      put :publish_individual

    end
    member do
      get :generate_zip
      get :generate_pdf
    end

  end

  resources :audits

  resources :environment_types

  resources :stores

  get "pages/home"
  get "pages/contact"
  get "pages/admin"

  resources :media_types

  resources :media_vehicles

  resources :media_locations

  resources :categories

  resources :brands

  resources :channels

  resources :store_formats

  resources :retailers

  resources :sectors

  resources :countries

  match '/pages/admin', :controller => 'pages', :action => 'admin', :as => 'admin'
  # match "photos/generate_zip", :controller => "photos", :action => 'gnerate_zip', :as => :download_zip
  match "photos/generate_zip" => "photos#generate_zip", :as =>  "download_zip"
  match "photos/generate_pdf" => "photos#generate_pdf", :as => "download_pdf"
  match '/photos/generate_zip/:id' => 'photos#generate_zip', :as => :download

  

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
  #  root :to => 'welcome#index'
  root :to => 'photos#index'
  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
  
end
