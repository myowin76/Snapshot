class PhotosController < ApplicationController

  autocomplete :store, :postcode
  def index
    
    # NEED TO CHECK WHEN PAGE LOAD, AGAINST USER SUBSCRIPTIONS
    if user_is_country_and_category_subscriber?
      
      @countries = Country.find(current_user.subscription.sub_country.split(","))
      @categories = Subscription.categories_by(current_user)

      unless params[:search].nil?
        
        unless params[:search][:sformat].blank?
          @store_formats = (params[:search][:sformat])
        else
          @store_formats = StoreFormat.all
        end
        # search
        if params[:search][:country_id].blank?
          # for all country search
          @stores_in_country = Store.find_all_by_country_id(@countries)
        else
          # for selected country
          @stores_in_country = Store.find_all_by_country_id(params[:search][:country_id])
        end

        if params[:search][:sectors].blank?
          @sectors = Sector.all
          #@retailers = Retailer.find_all_by_id(@sectors)  
          @retailers = Retailer.joins(:stores).select("distinct(retailers.id), retailers.*").where("stores.country_id IN (?)", @countries)
            
            unless params[:search][:retailers].blank? 
                @stores_in_country = Store.find(:all,
                  :conditions => ['country_id IN (?) AND retailer_id IN (?) AND store_format_id IN (?)', 
                  params[:search][:country_id], params[:search][:retailers], @store_formats])
            else
                @stores_in_country = Store.find(:all,
                  :conditions => ['country_id IN (?) AND retailer_id IN (?) AND store_format_id IN (?)',  
                  params[:search][:country_id], @retailers, @store_formats])    
            end
        else
          @sectors = Sector.all
          @sector_chk = Sector.find_all_by_id(params[:search][:sectors])  
          @retailers = Retailer.find_all_by_sector_id(@sector_chk)
          
          if params[:search][:country_id].blank?
            # for all country search
            @stores_in_country = Store.find_all_by_country_id(@countries)
          else
            # for selected country
            unless params[:search][:retailers].blank? 
                @stores_in_country = Store.find(:all,
                    :conditions => ['country_id IN (?) AND retailer_id IN (?)', 
                      params[:search][:country_id], params[:search][:retailers]])
            else
                @stores_in_country = Store.find(:all,
                    :conditions => ['country_id IN (?) AND retailer_id IN (?)', 
                      params[:search][:country_id], @retailers])
            end
          end  
        end
        unless params[:search][:postcode].blank? 
          @stores_in_country = Store.by_postcode(params[:search][:postcode])
          
        end
        
        
      else
        # page load

        @sectors = Sector.all
        @store_formats = StoreFormat.all
        #@retailers = Retailer.all
        @retailers = Retailer.joins(:stores).select("distinct(retailers.id), retailers.*").where("stores.country_id IN (?)", @countries)
        @stores_in_country = Store.find_all_by_country_id(@countries)
      end
      
      #@stores_in_country = Store.find_all_by_country_id(@countries)
      # @locations = Location.find_all_by_country_id(@countries)
      
      @audits_in_country = Audit.find_all_by_store_id(@stores_in_country)
      
     
      #@retailers = Retailer.joins(:stores).select("distinct(retailers.id), retailers.*")
     #   @retailers = Retailer.joins(:stores).select("distinct(retailers.id), retailers.*").where("stores.country_id IN (?)", @countries)
      
      
      
      @channels = Channel.all
      @locations = Location.find_all_by_country_id(@countries)
      @promo_calendars = PromotionCalendar.all
      @brands = Brand.all
      @themes = Theme.all
      @promo_types = PromotionType.all
      @media_types = MediaType.all
      @media_vehicles = MediaVehicle.all
      @media_locations = MediaLocation.all
      @env_types = EnvironmentType.all
      
      
      @search_param = params[:search]
      @saved_searches = current_user.save_searches.all
      #@new_save_search = current_user.save_searches.new
      if params[:search].nil?
        # search from current_user's scope  
        @photos = Photo.find(:all, 
          :conditions => ["audit_id in (?) AND category_id in (?)", 
            @audits_in_country, @categories])                    

      else 
         # CREATE NEW SEARCH SESSION ? T0 MAINTAIN THE STATE AND CAN SAVE IN DB
        # @store_in_country  NEED TO FILTER BY RETAILERS/SECTOR/STORE FORMAT
        #@photos = Photo.search(params[:search])

        unless params[:search][:postcode].blank?
          postcode = params[:search][:postcode]
        end
        
        unless params[:search][:fromDate].blank?
          from_date = DateTime.parse(params[:search][:fromDate])
        else
          from_date = DateTime.parse('01/01/1970')
        end
        unless params[:search][:toDate].blank?
          to_date = DateTime.parse(params[:search][:toDate])
        else
          to_date = DateTime.now
        end
        unless params[:search][:category].blank?
          @search_category = params[:search][:category]
        else
          @search_category = @categories
        end
        unless params[:search][:country_id].blank?
          @search_country = params[:search][:country_id]
        else
          @search_country = @countries
        end
        
        unless params[:search][:promo_cal].blank?
          @promo_cal = params[:search][:promo_cal]
        else
          @promo_cal = PromotionCalendar.all
        end
        unless params[:search][:promo_type].blank?
          @promo_type = params[:search][:promo_type]
        else
          @promo_type = PromotionType.all
        end
        unless params[:search][:env_type].blank?
          @env_type = params[:search][:env_type]
        else
          @env_type = EnvironmentType.all
        end
        
        unless params[:search][:pchannel].blank?
          @search_channel = params[:search][:pchannel]
        else
          @search_channel = @channels
        end
        unless params[:search][:media_type].blank?
          @search_mtype = params[:search][:media_type]
        else
          @search_mtype = @media_types
        end
        unless params[:search][:media_v].blank?
          @search_mv = params[:search][:media_v]
        else
          @search_mv = @media_vehicles
        end
        unless params[:search][:media_loc].blank?
          @search_ml = params[:search][:media_loc]
        else
          @search_ml = @media_locations
        end
        unless params[:search][:brand].blank?
          @search_brands = params[:search][:brand]
        else
          @search_brands = @brands
        end
        unless params[:search][:theme].blank?
          @search_themes = params[:search][:theme]
        else
          @search_themes = @themes
        end

        # save searches  
        @params = params[:search] unless params[:search].nil?
        
        @photos = Photo.joins(:audit)
              .where('photos.created_at >= (?) AND photos.created_at <= (?) AND category_id IN (?) AND promotion_calendar_id IN (?)
                    AND media_type_id IN (?) AND media_vehicle_id IN (?) AND media_location_id IN (?) AND brand_id IN (?)
                     AND brand_id IN (?)
                    AND audits.store_id IN (?) AND audits.environment_type_id IN (?) AND audits.channel_id IN (?)', 
                  from_date, to_date, @search_category, @promo_cal, @search_mtype, @search_mv, @search_ml, @search_brands, @search_themes,
                  @stores_in_country, @env_type, @search_channel)   
        
      end


    elsif user_is_country_subscriber?
      # TO CHECK ONLY COUNTRY/IES USER SUBSCRIBED
      @countries = Subscription.countries_by(current_user)
      @locations = Location.find_all_by_country_id(@countries)
      # if not post request with params(first load), find all photos OR with limit amount
      @stores_in_country = Store.find_all_by_country_id(@countries)
      
      #@retailers_in_country = Retailer.find_all_by_id(@store_in_country, :select => 'DISTINCT id', :order => 'name')
      @retailers = Retailer.all
      @audits_in_country = Audit.find_all_by_store_id(@stores_in_country)
      
      @categories = Category.all
      @photos = Photo.find_all_by_audit_id(@audits_in_country)  

    elsif user_is_category_subscriber?
      @countries = Country.all
      @stores_in_country = Store.find_all_by_country_id(@countries)
      @categories = Category.find(current_user.sub_cats.split(","))
      @photos = Photo.find_all_by_category_id(@categories)          
      #@audits = Audit.find_all_by_id(@stores_in_country)
      @retailers = Retailer.all
      
    else 
      # SOMETHING ELSE
      # @subscribed_country = "none"
    end

    #debugger
    #@photos = Photo.search(params[:search])    
  
    # MAP
    
      @json = @stores_in_country.to_gmaps4rails do |store, marker|
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
#debugger
    respond_to do |format|
      format.html  # index.html.erb
      format.json { 
        #render json: @photos 
      }
      format.js
    end
  end
  def postcode
    postcode = Store
  end
  # GET /photos/1
  # GET /photos/1.json
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

  # GET /photos/new
  # GET /photos/new.json
  def new
    @photo = Photo.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @photo }
    end
  end

  # GET /photos/1/edit
  def edit
    @photo = Photo.find(params[:id])
  end

  # POST /photos
  # POST /photos.json
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

  def get_photo
    
    #asset = Photo.find(params[:photo_ids])
    asset = Photo.find_by_id(12)
    #send_file asset.photo.url(:medium), :type => asset.photo_content_type
    redirect_to asset.photo.url(:medium)
    #open(asset.photo.url(:medium))
    #redirect_to root_path
  end

  def ajax_search_request
    index
    format.js
  end


  # PUT /photos/1
  # PUT /photos/1.json
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

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy

    respond_to do |format|
      format.html { redirect_to photos_url }
      format.json { head :no_content }
    end
  end
end
