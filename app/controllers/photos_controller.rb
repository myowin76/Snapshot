class PhotosController < ApplicationController
  include PhotosHelper


  def index
    
    if user_is_country_and_category_subscriber?
      if params[:saved_search_id] 
        saved = SaveSearch.find_by_id(params[:saved_search_id])
        if saved
          @saved_params = saved.to_params
        end  
      end

      @countries = Country.order(:name)
      #@countries = Country.find(current_user.subscription.sub_country.split(","))
      @categories = Category.order(:name)
      # @categories = Category.find(current_user.subscription.sub_cats.split(","))
      # need to check category and country
      # @stores = Store.where('country_id IN (?)', @countries.map(&:id))
      @stores = Store.order(:id).includes({:retailer => :sector})
      @sectors = Sector.order(:name)
      @store_formats = StoreFormat.order(:name)
          
      unless params_search.nil?

        # Country Search
        if search_country_id.present?
          # for selected country
          @stores = @stores.where('country_id = ? ', search_country_id)
        else
          @stores = @stores.where('country_id IN (?) OR country_id IS NULL', @countries.map(&:id))
          
        end

        @stores = @stores.where('store_format_id IN (?)', search_store_formats) if search_store_formats.present?
        # Location Search          
        @stores = @stores.near(search_location, 25, :order => :distance) if search_location.present?

        if search_sectors.present?          
          @retailers = Retailer.find_all_by_sector_id(search_sectors) #.includes(:sector)
          @stores = @stores.where('retailer_id IN (?)', @retailers.map(&:id))
        else
          @retailers = Retailer.find(:all, :include => :sector)
          # @retailers = Retailer.joins(:stores).select("distinct(retailers.id), retailers.*").where("stores.country_id IN (?)", @countries) 
        end
        if search_retailers.present?
          @stores = @stores.where('retailer_id IN (?)', search_retailers)
        else
          @stores = @stores.where('retailer_id IN (?)', @retailers)
        end  
          
      else
        # page load
        @sectors = Sector.order(:name)
        @retailers = Retailer.order(:name)
        # @retailers = Retailer.joins(:stores).select("distinct(retailers.id), retailers.*").where("stores.country_id IN (?)", @countries)
        @stores = @stores.includes(:retailer)
          .where('country_id IN (?) OR country_id IS NOT NULL', @countries.map(&:id))
      end
      
      @channels = Channel.order(:name)
      @promo_calendars = PromotionCalendar.order(:name)
      @brand_owners = BrandOwner.order(:name)
      @brands = Brand.order(:name)
      @themes = Theme.order(:name)
      @promo_types = PromotionType.order(:name)
      @media_types = MediaType.order(:name)
      @media_vehicles = MediaVehicle.order(:name)
      @media_locations = MediaLocation.order(:name)
      @env_types = EnvironmentType.order(:name)
      
      # @audits_in_country = Audit.find_all_by_store_id(@stores.map(&:id))
      @saved_searches = current_user.save_searches.all
      
      if params_search.nil?
        # on page load
        @photos = []
          
      else 
        # search action
          from_date = search_from_date.present? ? DateTime.parse(search_from_date) : DateTime.parse('01/01/1970')
          to_date = search_to_date.present? ? DateTime.parse(search_to_date) : DateTime.now
          @search_env_type = search_environment_types.present? ? search_environment_types : @env_types.map(&:id)
          @search_channel = search_channels.present? ? search_channels : @channels.map(&:id)

          @photos = Photo.by_audits_in_stores(@stores, @search_env_type, @search_channel)
              .includes(:brands)
                    
            if search_promotion_types.present?
              @photos = @photos.joins(:promotion_types).where('promotion_types.id IN (?)', search_promotion_types)
            end  
            unless search_promotion_calendars.present?
              @photos = @photos.where('promotion_calendar_id IS NULL OR promotion_calendar_id IN (?)', @promo_calendars.map(&:id)) 
            else
              @photos = @photos.where('promotion_calendar_id IN (?)', search_promotion_calendars)
            end  
            
            if search_media_types.present?
              @photos = @photos.joins(:media_types).where('media_types.id IN (?)', search_media_types)
            end
            if search_media_vehicles.present?
              @photos = @photos.joins(:media_vehicles).where('media_vehicles.id IN (?)', search_media_vehicles)
            end
            
            @photos = @photos.joins(:media_locations).where('media_locations.id IN (?)', search_media_locations) if search_media_locations.present?
            
            if search_brand_owners.present?
              @brands_by_owners = @brands.find_all_by_brand_owner_id(search_brand_owners)
              @photos = @photos.joins(:brands).where('brands.id IN (?)', @brands_by_owners)
            end
            if search_brands.present?
              @photos = @photos.joins(:brands).where('brands.id IN (?)', search_brands)
            end
            if search_themes.present?
              @photos = @photos.joins(:themes).where('themes.id IN (?)', search_themes)
            end
            if search_categories.present?
              @photos = @photos.includes(:categories).where('categories.id IN (?)', search_categories)
            end            

            @photos = @photos.find_between(from_date,to_date)

            
            #### need to refactor the queries #####  

            @photo_audits = @photos.select('DISTINCT audit_id').map(&:audit_id)
            @audits = Audit.find_all_by_id(@photo_audits)
            @store_ids = []
            @audits.each do |s|
              @store_ids.push(s.store_id)
            end
            
            @stores = @stores.where('stores.id IN (?)', @store_ids)
            @stores = @stores.where('stores.country_id IS NOT NULL')
            @photos = @photos.paginate(:page => params[:page], :per_page => 20)
            
      end

    elsif user_is_country_subscriber?
    elsif user_is_category_subscriber?
    else 
      # SOMETHING ELSE
    end

    # MAP
    # debugger
      @json = @stores.to_gmaps4rails do |store, marker|
        marker.infowindow render_to_string(:partial => "/photos/info_window", :locals => { :store => store })
        marker.picture({
                        #:picture => "http://www.blankdots.com/img/github-32x32.png",
                        #:width   => 32,
                        #:height  => 32
                       })
        marker.title   store.name

        # marker.sidebar "i'm the sidebar"
        # marker.json({ :id => user.id, :foo => "bar" })
      end    

    respond_to do |format|
      format.html  # index.html.erb
      format.json { 
        #render json: @photos 
      }
      format.js
    end
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
      format.json { render json: @photo }
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
  end

  def create
    @photo = Photo.new(params[:photo])

    respond_to do |format|
      if @photo.save
        format.html { redirect_to @photo, notice: 'Photo was successfully created.' }
        format.json { render json: @photo, status: :created, location: @photo }
      else
        format.html { render action: "new" }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end


  def generate_zip

    zip_file = Photo.zip_files(params[:photo_ids].split(','))
    if zip_file
      send_file zip_file, :type => 'application/zip', :disposition => 'attachment', :filename => "export"
      zip_file.close
    end
  end

  def generate_pdf
    # @photo_list = Photo.find(params[:photo_ids])
    @photo_list = Photo.find_all_by_id(params[:photo_ids].split(','))
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

    respond_to do |format|
      if @photo.update_attributes(params[:photo])
        format.html { redirect_to @photo, notice: 'Photo was successfully updated.' }
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
      format.html { redirect_to photos_url }
      format.json { head :no_content }
    end
  end

  def publish_individual
    
    @photo = Photo.find(params[:id])
    if @photo.update_attributes(:published => true)
      flash[:notice] = "Selected Images successfully Published."  
      redirect_to admin_path
    else
      flash[:notice] = "Error occured during publish..please try again"  
      redirect_to photo_path(@photo)
      
    end  
    
  end

  def publish_multiple
    
    if params[:photo_ids].present?
      @photos = Photo.find(params[:photo_ids])
      @photos.each do |photo|
        photo.update_attributes(:published => true)
      end
      flash[:notice] = "Selected Images successfully Published."  
    else
      flash[:notice] = "Please Select one or more image"
    end  
    
    redirect_to admin_path
    
  end

  def refresh_retailers
    if params[:search].nil?
      @retailers = Retailer.all
    else
      @retailers = Retailer.find_all_by_sector_id(params[:search][:sectors])
    end
    respond_to do |format|
      format.js {
        render :partial => 'refresh_retailers', :locals => { :retailers => @retailers }
      }
    end
  end
  def refresh_brands
    if params[:search].nil?
      @brands = Brand.all
    else
      @brands = Brand.find_all_by_brand_owner_id(params[:search][:brand_owners])
    end  
    respond_to do |format|
      format.js {
        render :partial => 'refresh_brands', :locals => { :brands => @brands }
      }
    end
  end

  def check_counts
    


  end
  
end