Snapshot::Application.routes.draw do

  resources :subscriptions, :save_searches, :user_types
  resources :media_types, :media_vehicles, :media_locations, :themes
  resources :channels, :store_formats, :brands, :brand_owners, :categories, :environment_types
  resources :sectors,:retailers, :countries, :promotion_calendars, :promotion_types

  # resources :categories do
  #   resources :photos
  # end

  devise_for :users
  match '/photos/generate_pdf' => 'photos#generate_pdf', :as => :as_pdf
  match '/photos/generate_zip' => 'photos#generate_zip', :as => :download
  #match '/stores/view/:id' => 'photos#show_store_with_categories', :as => :store_view
  
  resources :photos do
    collection do
      put :publish_multiple
      put :publish_individual
      post :refresh_brands
      post :refresh_retailers
    end    
  end

  resources :audits do
    collection do
      post :refresh_store_dropdown
    end
  end
  match '/stores/show_store_with_categories' => 'stores#show_store_with_categories', :as => :store_view
  resources :stores do
    collection do
      # post :show_store_with_categories
      post :refresh_store_view_categories
      post :get_store_details
      
    end
  end

  get "pages/home"
  get "pages/about"
  get "pages/consultancy"
  get "pages/reports"
  get "pages/news"
  get "pages/contact"
  get "pages/admin"

  match '/pages/admin', :controller => 'pages', :action => 'admin', :as => 'admin'
  

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
