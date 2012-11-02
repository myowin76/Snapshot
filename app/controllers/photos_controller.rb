class PhotosController < ApplicationController
  # GET /photos
  # GET /photos.json
  def index
    
    # NEED TO CHECK WHEN PAGE LOAD, AGAINST USER SUBSCRIPTIONS
    if user_is_country_and_category_subscriber?
      
      #@countries = Subscription.countries_by(current_user)
      @countries = Country.find(current_user.subscription.sub_country.split(","))
      #if params[:search].blank?
#debugger        
 #       @stores_in_country = Store.find_all_by_country_id(params[:search][:country_id])
  #    else 

        @stores_in_country = Store.find_all_by_country_id(@countries)
        
   #   end
      # @locations = Location.find_all_by_country_id(@countries)
      
      @audits_in_country = Audit.find_all_by_store_id(@stores_in_country)
      @categories = Subscription.categories_by(current_user)
      #debugger
      #@retailers = Retailer.joins(:stores).select("distinct(retailers.id), retailers.*")
      @retailers = Retailer.joins(:stores).select("distinct(retailers.id), retailers.*").where("stores.country_id IN (?)", @countries)
      @sectors = Sector.all
      @promo_calendar = PromotionCalendar.all
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
        
        unless params[:search][:from_date].blank?
          from_date = DateTime.parse(params[:search][:from_date])
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
          search_country = params[:search][:country_id]
        else
          search_country = @countries
        end
        
        unless params[:search][:promo_cal].blank?
          @promo_cal = params[:search][:promo_cal]
        else
          @promo_cal = PromotionCalendar.all
        end
        #unless params[:search][:promo_type].blank?
        #  @promo_type = params[:search][:promo_type]
        #else
        #  @promo_type = PromotionType.all
        #end
        unless params[:search][:env_type].blank?
          @env_type = params[:search][:env_type]
        else
          @env_type = EnvironmentType.all
        end

        # save searches  
        @search_param = params[:search]
        #@photos = Photo.joins(:audit).where('photos.created_at >= (?) AND photos.created_at <= (?) AND category_id IN (?) 
        #  AND audits.store_id IN (?)', 
        #          @from_date, @to_date, params[:search][:category], @audits_in_country)    

        #@photos = Photo.joins(:audit)
        #      .where('photos.created_at >= (?) AND photos.created_at <= (?) AND category_id IN (?) 
        #            AND audits.store_id IN (?) AND promotion_calendar_id IN (?) AND audits.environment_type_id IN (?)', 
        #          @from_date, @to_date, @search_category, @search_country, @promotion_cal, @env_type )    
        @photos = Photo.joins(:audit)
              .where('photos.created_at >= (?) AND photos.created_at <= (?) AND category_id IN (?) AND promotion_calendar_id IN (?)
                    AND audits.store_id IN (?)', 
                  from_date, to_date, @search_category, @promo_cal, @audits_in_country)   

        
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
      
    @sectors = Sector.all
    
    #@stores = Store.all
    @channels = Channel.all
    @environment_types = EnvironmentType.all

    #@photos = Photo.search(params[:search])    
    
    @locations = Location.find_all_by_country_id(@countries)
    
    @promo_type = PromotionType.all
    #@stores = Store.search(params[:search])
    
    # need to filter by search
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

    respond_to do |format|
      format.html  # index.html.erb
      format.json { 
        #render json: @photos 
      }
      format.js
    end
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
    @photo = Photo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
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
    
    asset = Photo.find(params[:photo_ids])
    #assets = Photo.find(params[:chk])
    send_file 'http://s3.amazonaws.com/SnapshotWorldWide'+asset.photo.path, :type => asset.photo_content_type
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
