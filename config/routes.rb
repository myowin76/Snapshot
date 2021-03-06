Snapshot::Application.routes.draw do


  


  resources :projects


  resources :settings


  # namespace :admin do
  #   resources :roles
  # end


  # devise_for :users
  devise_for :users,  :controllers => { :sessions => "users/sessions"}
  devise_for :users, :controllers => {:registrations => "registrations"}
  # devise_for :users, :controllers => { :registrations => "users" }
  
  scope "/admin" do
    resources :users do
      resources :subscriptions

    end
  end  


  resources :save_searches, :user_types
  scope "admin" do
    resources :companies
  end
    resources :media_types, :media_vehicles, :media_locations, :themes
    resources :channels, :store_formats, :brands, :brand_owners, :categories, :environment_types
    resources :sectors, :retailers, :countries, :promotion_calendars, :promotion_types

    # resources :audits
  # end
  
  # match '/photos/generate_pdf' => 'photos#generate_pdf', :as => :as_pdf
  match '/photos/generate_zip' => 'photos#generate_zip', :as => :download
  match '/photos/download/:id' => 'photos#zip_all_from_store', :as => :all_store_photos
  # match '/photos/edit_multiple' => 'photos#edit_multiple', :as => :edit_multiple
  # match '/photos/publish_checked' => 'photos#publish_multiple', :as => :publish_checked
  # match '/photos/delete_checked' => 'photos#delete_multiple', :as => :delete_checked


  # match '/audits/:id/photos/edit_multiple' => 'audits#edit_multiple', :as => :edit_multiple_audit 
  match '/audits/:id/photos/edit_multiple' => 'photos#edit_multiple', :as => :edit_multiple_audit_photos 
  match '/audits/:id/photos/update_multiple' => 'photos#update_multiple', :as => :update_multiple_audit_photos

  match '/photos/edit_multiple' => 'photos#edit_multiple', :as => :edit_multiple_photos
  resources :audits do
    collection do
      get :edit_multiple
      put :update_multiple
      post :refresh_store_dropdown

    end
    resources :photos
  end

  resources :photos do
    collection do
      # put :publish_multiple
      get :generate_pdf
      post :publish_multiple
      post :delete_multiple
      put  :publish_individual
      post :refresh_brands
      post :refresh_retailers
      post :refresh_brands_dropdown
      post :refresh_all_brands_dropdowns
      post :update_brand_owners_dropdown
      post :preselect_brand_owners
      get  :search
      get  :all_photos
      get  :all_filters
      
      get :edit_multiple
      put :update_multiple


    end    
  end

  match '/audits/mv_create' => 'audits#mv_create' 
  match '/stores/clear_filters' => 'stores#show', :as => :clear_filters
  match '/store/:store_id/category_view/:id' => 'stores#store_category_view', :as => :category_view
  resources :stores do
    collection do
      post :show_store_with_categories
      post :refresh_store_view_categories
      post :get_store_details
      post :refresh_category_view_photos
    end
    resources :audits
  end

  get "admin/home"
  get "admin/about"
  get "admin/consultancy"
  get "admin/reports"
  get "admin/news"
  get "admin/contact"

  match '/admin/dashboard', :controller => 'admin', :action => 'dashboard', :as => 'dashboard'
  match '/admin/unpublished', :controller => 'admin', :action => 'raw_photos', :as => 'unpublished'
  # match '/admin/audits', :controller => 'audits', :action => 'index', :as => 'audits'
  match '/admin/users', :controller => 'users', :action => 'index'#, :as => 'users'
  match '/admin/loginpage_message', :controller => 'admin', :action => 'loginpage_message'

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
