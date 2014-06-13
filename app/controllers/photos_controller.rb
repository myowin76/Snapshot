class PhotosController < ApplicationController
  include PhotosHelper
  before_filter :authenticate_user!
  before_filter :get_user, :only => [:edit, :destroy]
  before_filter :accessible_roles, :only => [:show]
  load_and_authorize_resource :only => [:new,:destroy,:edit,:update]
  # authorize_resource :class => false

  respond_to :html, :js, :json
  respond_to :pdf#, :only => :show

  
  def index


      if params[:saved_search_id] 
        saved = SaveSearch.find_by_id(params[:saved_search_id])
        if saved
          @saved_params = saved.to_params
        end  
      end

      # AUTHORIZED THE SUBSCRIPTIONS
      if user_is_category_subscriber?
        @categories = Category.order(:name).find_all_by_id(current_user.subscription.sub_cats.split(","))
      else  
        @categories = Category.order(:name)
      end  

      if user_is_project_subscriber?
        @projects = Project.order(:name).find_all_by_id(current_user.subscription.projects.split(","))
      # else  
      #   @projects = Project.order(:name)
      end      

      if user_is_sector_subscriber?
        @sectors = Sector.order(:name).find_all_by_id(current_user.subscription.sectors.split(","))
      else  
        @sectors = Sector.order(:name)
      end

      if user_is_country_subscriber?
        @countries = Country.find_all_by_id(current_user.subscription.sub_country.split(","))
      else          
        @countries = Country.order(:name)  
      end
      

      unless params[:per_page].present? || params[:page].present?
        @store_formats = StoreFormat.order(:name)
        @env_types = EnvironmentType.order(:name)
        @channels = Channel.order(:name)
      end

      # initiate stores.  
      @stores = Store.order(:id)#.includes({:retailer => :sector})
      
      unless params_search.nil?
        
        # Country Search
        if search_country_id.present?
          # for selected country
          @stores = @stores.in_country(search_country_id)
        else
          @stores = @stores.in_countries_and_null(@countries.map(&:id))
        end

        @stores = @stores.with_environment_type(search_environment_types) if search_environment_types.present?
        @stores = @stores.with_channel(search_channels) if search_channels.present?
        @stores = @stores.with_format(search_store_formats) if search_store_formats.present?
        # Location Search          
        @stores = @stores.within_25_miles_of(search_location) if search_location.present?

        if search_sectors.present?
          
            @retailers = Retailer.order(:name).find_all_by_sector_id(search_sectors)
            # debugger
            unless search_retailers.present?
              @stores = @stores.of_retailers(@retailers.map(&:id))
            else
              @stores = @stores.of_retailers(search_retailers)
            end

        else
          if user_is_sector_subscriber?
            @retailers = Retailer.order(:name).find_all_by_sector_id(@sectors.map(&:id))
          else
            @retailers = Retailer.order(:name)
          end  
          
          if user_is_retailer_subscriber?
            @sub_retailers = Retailer.order(:name).find_all_by_id(current_user.subscription.retailers.split(","))
            @retailers = @retailers + @sub_retailers
          end

          if search_retailers.present?
            @stores = @stores.of_retailers(search_retailers)
          else
            @stores = @stores.of_retailers(@retailers.map(&:id))
          end
        end
          
      else

        # ON PAGE LOAD

        if user_is_sector_subscriber?
          @retailers = Retailer.order(:name).find_all_by_sector_id(@sectors.map(&:id))
          
          if user_is_retailer_subscriber?
            @sub_retailers = Retailer.order(:name).find_all_by_id(current_user.subscription.retailers.split(","))
            @retailers = @retailers + @sub_retailers
            @retailers = @retailers.sort_by! {|n| n.name}
          end

        else  

          if user_is_retailer_subscriber?
            @sub_retailers = Retailer.order(:name).find_all_by_id(current_user.subscription.retailers.split(","))
            @retailers = @sub_retailers
            @retailers = @retailers.sort_by! {|n| n.name}
          else
            @retailers = Retailer.order(:name)
          end

        end

        if user_is_project_subscriber?

        end
          @stores = @stores.includes(:retailer)
            .in_countries_and_null(@countries.map(&:id))
            .of_retailers(@retailers.map(&:id))
          
      end

      # skips those on ajax calls
      unless params[:per_page].present? || params[:page].present?

        @promo_calendars = PromotionCalendar.order(:name)
        @brand_owners = BrandOwner.order(:name)
        @brands = Brand.order(:name)
        @themes = Theme.order(:name)
        @promo_types = PromotionType.order(:name)
        @media_types = MediaType.order(:name)
        @media_vehicles = MediaVehicle.order(:name)
        @media_locations = MediaLocation.order(:name)
      end


      @saved_searches = current_user.save_searches.all

      if params[:per_page].present?
        @per_page = params[:per_page]
      else
        @per_page = 30
      end

      # initiate Photo object
      if user_is_project_subscriber?
        
        @projects = Project.find(current_user.subscription.projects.split(','))
        @photos = Photo.joins(:projects).where('projects.id IN (?)', @projects.map(&:id))
        
      else
        @photos = Photo.published  
      end
      
      # @audits = Audit.find_all_by_store_id(@stores.map(&:id))
      # @photos = Photo.find_all_by_audit_id(@audits.map(&:id))
      
        if params_search.nil?
          
          @photos = @photos
            .published
            .select('photos.id, photos.photo_file_name, photos.audit_id, photos.photo_updated_at')
            .order('audits.audit_date DESC, photos.created_at DESC')
            .includes([:audit, :brands])
            .paginate(:page => params[:page], :per_page => @per_page)

# .where('audit_id IN (?)', @audits.map(&:id))
            @photo_audits = @photos.select('DISTINCT audit_id').map(&:audit_id)

            @audits = Audit.find_all_by_id(@photo_audits)
          
            @store_ids = @audits.map(&:store_id)

            @stores = @stores.where('stores.id IN (?)', @store_ids).where('stores.country_id IS NOT NULL')

          
        else 
      
        
        # SEARCH / FILTER
          from_date = search_from_date.present? ? DateTime.parse(search_from_date) : DateTime.parse('01/01/1970')
          to_date = search_to_date.present? ? DateTime.parse(search_to_date) : DateTime.now
          
          # @photos = @photos.select('photos.id, photos.photo_file_name, photos.audit_id, photos.photo_updated_at')
          if user_is_project_subscriber?
        
            @projects = Project.find(current_user.subscription.projects.split(','))
            if search_projects.present?
              @photos = Photo.joins(:projects).where('project_id IN (?)', search_projects)
            else
              @photos = Photo.joins(:projects)
            end
            
          else
            @photos = Photo.published  
          end

          @photos = @photos.select('photos.id, photos.photo_file_name, photos.audit_id, photos.photo_updated_at')
              .where('audit_id IN (?)', @audits.map(&:id)).published
          @photos = @photos.by_audits_in_stores(@stores)
              .includes(:brands)

          @photos = @photos.of_promotion_calendar(search_promotion_calendars) if search_promotion_calendars.present?
          @photos = @photos.of_promotion_types(search_promotion_types) if search_promotion_types.present?
          @photos = @photos.of_media_types(search_media_types) if search_media_types.present?
          @photos = @photos.of_media_vehicles(search_media_vehicles) if search_media_vehicles.present?
          @photos = @photos.of_media_locations(search_media_locations) if search_media_locations.present?
          @photos = @photos.of_brands(search_brands) if search_brands.present?
          @photos = @photos.of_themes(search_themes) if search_themes.present?
          @photos = @photos.of_categories(search_categories) if search_categories.present?
          # @photos = @photos.all_brand_compliant if search_brand_compliant?

          
          if search_brand_owners.present?
            
            @brands_by_owners = @brands.find_all_by_brand_owner_id(search_brand_owners)
            @photos = @photos.joins(:brands).where('brands.id IN (?)', @brands_by_owners)
          end

          @photos = @photos.find_between(from_date, to_date)

          @photo_audits = @photos.select('DISTINCT audit_id').map(&:audit_id)

          @audits = Audit.find_all_by_id(@photo_audits)
        
          @store_ids = @audits.map(&:store_id)

          @stores = @stores.where('stores.id IN (?)', @store_ids).where('stores.country_id IS NOT NULL')
          
          @photos = @photos.paginate(:per_page => @per_page, :page => params[:page])
              .order('audits.audit_date DESC, photos.created_at DESC')

            
        end
      # debugger
    # MAP
    
    unless @stores.blank?
      @json = @stores.to_gmaps4rails do |store, marker|
        marker.infowindow render_to_string(:partial => "/photos/info_window", :locals => { :store => store })
        marker.title   store.name
      end
    else 
      @json = []
    end      

    
    # respond_to do |format|
    #  format.json { render json: @photos.as_json(
    #     only: [:id, :audit_id, :photo_file_name, :photo_content_type,:promotion_calendar_id]
    #     )}
    # end
    # respond_with @photos
  end

  def show

    @photo = Photo.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.pdf do
        pdf = PhotoPdf.new(@photo)
        send_data pdf.render, file_name: "photo_#{"photo.photo_file_name"}.pdf",
                      type: "application/pdf",
                      disposition: "inline"
      end
      format.js
      format.json { render json: @photo.to_jbuilder}
    end
  end

  def new
    
    @photo = Photo.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @photo }
    end
  end

  def edit

    @photo = Photo.find(params[:id])
    unless @photo.brands.empty?
      @brands = @photo.brands
      @brand_owner = @brands.first.brand_owner.name unless @brands.first.brand_owner.nil?

    end
  end

  def create
    
    # @photo = Photo.new(params[:photo])
    if params[:photo].present?
      if params[:audit_id].present?
        @photo = Photo.new(params[:photo])
        audit_id = params[:audit_id]
        @photo.update_attribute(:audit_id, params[:audit_id])
        # debugger
      elsif params[:photo][:audit_id].present? 
        @photo = Photo.new(params[:photo])
        audit_id = params[:photo][:audit_id]  
      end
    end
    
    respond_to do |format|
      if @photo.save
         if params[:brand_ids].present?
          @brands = Brand.find_all_by_id(params[:brand_ids].join(",").split(","))
          @photo.brands = @brands
         end 
         if params[:category_ids].present?
          @cats = Category.find_all_by_id(params[:category_ids].join(",").split(","))
          @photo.categories = @cats
         end 
         if params[:media_location_ids].present?
          @mls = MediaLocation.find_all_by_id(params[:media_location_ids].join(",").split(","))
          @photo.media_locations = @mls
         end 
         if params[:media_type_ids].present?
          @mts = MediaType.find_all_by_id(params[:media_type_ids].join(",").split(","))
          @photo.media_types = @mts
         end 
         if params[:media_vehicle_ids].present?
          @mvs = MediaVehicle.find_all_by_id(params[:media_vehicle_ids].join(",").split(","))
          @photo.media_vehicles = @mvs
         end 
         if params[:promotion_type_ids].present?
          @pts = PromotionType.find_all_by_id(params[:promotion_type_ids].join(",").split(","))
          @photo.promotion_types = @pts
         end 
         if params[:themes_ids].present?
          @themes = Theme.find_all_by_id(params[:themes_ids].join(",").split(","))
          @photo.themes = @themes
         end 
        
        # @photo.update_attributes(params[:category_ids].join(",").split(",")) if params[:category_ids].present?

         

        format.html {
            render :json => [@photo.to_jq_upload].to_json,
            :content_type => 'text/html',
            :layout => false
          }
        # if params[:api_request].present?
        #   format.json { render json: @photo, status: :created, location: @photo }
        # else
          format.json { render json: [@photo.to_jq_upload].to_json, status: :created, location: @photo }
        # end  
        # format.html { redirect_to @photo, notice: 'Photo was successfully created.' }
        # format.json { render json: @photo, status: :created, location: @photo }
      else
        format.html { render action: "new" }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  def generate_zip
    
    zip_file = Photo.zip_files(params[:photo_ids].split(','))
    if zip_file
      send_file zip_file, :type => 'application/zip', :disposition => 'attachment', :filename => "export.zip"
      zip_file.close
    end
  end

  def zip_all_from_store
    store = Store.find(params[:id])

    # debugger
    zip_file = Photo.zip_all_from_store(current_user, store)
    
    if zip_file
      send_file zip_file, :type => 'application/zip', :disposition => 'attachment', :filename => "#{store.name}.zip"
      zip_file.close
    end
  end

  def generate_pdf
    @photo_list = params[:photo_ids]
    # @photo_list = Photo.find_all_by_id(params[:photo_ids].split(','))

    respond_to do |format|
      format.pdf do
        pdf = PhotoListPdf.new(@photo_list)
        
        send_data pdf.render, file_name: "photo_list.pdf",
                      type: "application/pdf",
                      disposition: "inline"

      end
    end  
  end

  def update
    @photo = Photo.find(params[:id])
    @audit = Audit.find_by_id(params[:photo][:audit_id])
    
    respond_to do |format|
      if @photo.update_attributes(params[:photo])
        unless @audit.nil?
          format.html { redirect_to @audit, notice: 'Photo was successfully updated.' }            
        else
          format.html { redirect_to @photo, notice: 'Photo was successfully updated.' }
        end  
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def destroy
    
    @photo = Photo.find(params[:id])
    @photo.destroy

    respond_to do |format|
      # format.html { redirect_to photos_url }
      if params[:audit_id].present?
        url = "#{root_path}audits/#{params[:audit_id]}"
        
        format.html { redirect_to url }
      else
        format.html { redirect_to admin_url }
      end  
        format.json { head :no_content }
    end
  end

  def publish_individual
    # debugger
    @photo = Photo.find(params[:id])

    if @photo.update_attributes(:published => true)
      flash[:notice] = "Selected Images successfully Published."  
        redirect_to photo_path(@photo)
    else
      flash[:notice] = "Error occured during publish..please try again"  
      redirect_to photo_path(@photo)
      
    end  
    
  end

  def publish_multiple
    
    if params[:checkbox_array].present?
      @photos = Photo.find_all_by_id(params[:checkbox_array])
      @photos.each do |photo|
        photo.update_attributes(:published => true)
      end
      flash[:notice] = "Selected Images successfully Published."  

    else
      flash[:notice] = "Please Select one or more image"
    end  
    
    render "admin/unpublished"
    
  end

  def delete_multiple
    
    if params[:checkbox_array].present?
      # @photos = Photo.find_all_by_id(params[:checkbox_array])
      # debugger
      # @photos.each do |photo|
      #   photo.destroy
      # end
      Photo.destroy(params[:checkbox_array])
      flash[:notice] = "Selected Images Deleted."  
    else
      flash[:notice] = "Please Select one or more image"
    end  
    
    redirect_to unpublished_path
    
  end

  def refresh_retailers
    if params[:search].nil?
      @retailers = Retailer.order(:name)
    else
      @retailers = Retailer.order(:name).find_all_by_sector_id(params[:search][:sectors])
    end

    respond_to do |format|
      format.js {
        render :partial => 'refresh_retailers', :locals => { :retailers => @retailers }
      }
    end
  end

  def refresh_brands
    if params[:search].nil?
      @brands = Brand.order(:name)
    else
      @brands = Brand.order(:name).find_all_by_brand_owner_id(params[:search][:brand_owners])
    end  
    respond_to do |format|
      format.js {
        render :partial => 'refresh_brands', :locals => { :brands => @brands }
      }
    end
  end

  def refresh_brands_dropdown
    
    if params[:brand_owner_id].present?
      brand_owner = BrandOwner.find(params[:brand_owner_id])
      @brands = brand_owner.brands
    else
      @brands = Brand.order(:name).all
    end
    respond_to do |format|
      format.js {
        render :partial => 'refresh_brands_dropdown' #, :locals => { :retailers => @retailers }
      }
    end
  end

  def refresh_all_brands_dropdowns
    
    @select_id = params[:select_id]
    unless params[:pre_selected_brand_ids].nil?
      @pre_select_brands = params[:pre_selected_brand_ids]
      @pre_select_brands = @pre_select_brands.join(",")
    end

    if params[:brand_owner_id].present?
      # brand_owner = BrandOwner.find_all_by_id(params[:brand_owner_id])
      # @brands = brand_owner.brands
      @brands = Brand.find_all_by_brand_owner_id(params[:brand_owner_id])
    else
      @brands = Brand.order(:name).all
    end  
        
    respond_to do |format|
      format.js {
        render :partial => 'refresh_all_brands_dropdowns' #, :locals => { :retailers => @retailers }
      }
    end
  end

  def update_brand_owners_dropdown
    
    @brand_owner_ddl_id = params[:brand_owner_ddl_id]
    @pre_brand_ids = params[:pre_selected_brand_ids]

    if params[:brand_ids].present?
      @brands =  Brand.find_all_by_id(params[:brand_ids])
      @brand_owner_ids = @brands.map(&:brand_owner_id).join(",")
    else  
    end
    
    respond_to do |format|
      format.js {
        render :partial => 'update_brand_owners_dropdown'
      }
    end
  end

  def preselect_brand_owners
    # debugger
    unless params[:brands_ddl_id].empty?
      @brands_ddl_id = params[:brands_ddl_id]
    end
    unless params[:brand_owners_ddl_id].nil?
      @brand_owners_ddl_id = params[:brand_owners_ddl_id]
    end
    unless params[:brand_ids].nil?
      @brands = Brand.find_all_by_id(params[:brand_ids])
      @brand_owners_ids = @brands.map(&:brand_owner_id).join(",")
    end  
    
    respond_to do |format|
      format.js {
        render :partial => 'preselect_brand_owners'
      }
    end
  end

  # def refresh_uploader_mv_dropdowns
  #   @select_id = params[:select_id]
  #   # debugger
  #   if params[:brand_owner_id].present?
  #     brand_owner = BrandOwner.find(params[:brand_owner_id])
  #     @brands = brand_owner.brands
  #   else
  #     @brands = Brand.order(:name)
  #   end  
    
  #   respond_to do |format|
  #     format.js {
  #       render :partial => 'refresh_all_brands_dropdowns' #, :locals => { :retailers => @retailers }
  #     }
  #   end
  # end


  def all_photos
    @photos = Photo.order(:created_at)
    # .includes(:brands)
  end

  def search
    # @countries = Country.select("id, name")
    # @store_formats = StoreFormat.select("id, name")
    # @env_types = EnvironmentType.select("id, name")
    # @channels = Channel.select("id, name")
    # @promo_calendars = PromotionCalendar.select("id, name")
    # @brand_owners = BrandOwner.select("id, name")
    # @brands = Brand.select("id, name")
    # @themes = Theme.select("id, name")
    # @promo_types = PromotionType.select("id, name")
    # @media_types = MediaType.select("id, name")
    # @media_vehicles = MediaVehicle.select("id, name")
    # @media_locations = MediaLocation.select("id, name")
    
    # @photos = Photo.order(:created_at)
    # .includes(:brands)
    @photos = Photo.select('id, audit_id, photo_file_name, photo_updated_at')
    # debugger
    # .select("photos.id, photos.photo_file_name, photos.audit_id")
    # .paginate(:page => params[:page])
    # respond_to do |format|
    #   format.html # index.html.erb
    #   format.json { render json: @photos }
    # end  
  end

  def all_filters
  
    # @countries = Country.select("id, name")
    @categories = Category.select("id, name")
    @sectors = Sector.select("id, name")
    @retailers = Retailer.select("id, name, sector_id")
    # @store_formats = StoreFormat.select("id, name")
    # @env_types = EnvironmentType.select("id, name")
    # @channels = Channel.select("id, name")
    # @promo_calendars = PromotionCalendar.order(:name)
    # @brand_owners = BrandOwner.order(:name)
    # @brands = Brand.order(:name)
    # @themes = Theme.order(:name)
    # @promo_types = PromotionType.order(:name)
    # @media_types = MediaType.order(:name)
    # @media_vehicles = MediaVehicle.order(:name)
    # @media_locations = MediaLocation.order(:name)



  end

  def edit_multiple
    # debugger
    # @photos = Photo.unpublished
    # @photos = Photo.find(params[:audit_photo_ids])
    # debugger
    @photo = Photo.find(4741)
    respond_to do |format|
      format.html # index.html.erb
      format.js
    end  
  end

  def update_multiple
    # debugger
    @photos = Photo.update(params[:photos].keys, params[:photos].values).reject { |p| p.errors.empty? }
    @audit = Audit.find(params[:id])

    if @photos.empty?
      # unless params[:audit_id].nil?
        respond_to do |format|  
          format.html { redirect_to @audit, notice: 'Successfully updated.' }
          format.js
        end
      # end      
      # redirect_to photos_url
    else
      # render :action => "edit_multiple_audit_photos_url"
    end
  end
  
end