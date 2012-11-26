class PhotosController < ApplicationController

  autocomplete :store, :postcode

  def index
    
    if user_is_country_and_category_subscriber?
      
      @countries = Country.find(current_user.subscription.sub_country.split(","))
      @categories = Category.find(current_user.subscription.sub_cats.split(","))
      # need to check category and country
      @stores = Store.where('country_id IN (?)', @countries.map(&:id))
      @store_formats = StoreFormat.order(:name)
      
      # @categories = Subscription.categories_by(current_user)

      unless params[:search].nil?
        
        # Country Search
        if params[:search][:country_id].present?
          # for selected country
          @stores = @stores.where('country_id IN (?)', params[:search][:country_id])
        # else
        #   # for all country search
        #   @stores_in_country = @stores.where('country_id IN (?)', @countries.map(&:id))
        end

        if params[:search][:sformat].present?
          # @store_formats = (params[:search][:sformat])
          @stores = @stores.where('store_format_id IN (?)', params[:search][:sformat])
        end
        # Location Search
        if params[:search][:location].present?
          @stores = @stores.near(params[:search][:location], 25, :order => :distance)
          # .where('id IN (?)', ['5','9'])    
        end 

        if params[:search][:sectors].present?
          @stores = @stores.joins(:retailer).where('retailers.sector_id IN (?)', params[:search][:sectors])
          @retailers = Retailer.find_all_by_sector_id(params[:search][:sectors])
        else
          @retailers = Retailer.joins(:stores).select("distinct(retailers.id), retailers.*").where("stores.country_id IN (?)", @countries) 
        end

        if params[:search][:retailers].present?
          @stores = @stores.where('retailer_id IN (?)', params[:search][:retailers])
        end
          
      else
        # page load
        @sectors = Sector.order(:name)
        @retailers = Retailer.joins(:stores).select("distinct(retailers.id), retailers.*").where("stores.country_id IN (?)", @countries)
        @stores = @stores.where('country_id IN (?)', @countries.map(&:id))
      end
      
      
      @channels = Channel.order(:name)
      @promo_calendars = PromotionCalendar.order(:name)
      @brands = Brand.order(:name)
      @themes = Theme.order(:name)
      @promo_types = PromotionType.order(:name)
      @media_types = MediaType.order(:name)
      @media_vehicles = MediaVehicle.order(:name)
      @media_locations = MediaLocation.order(:name)
      @env_types = EnvironmentType.order(:name)
      

      @audits_in_country = Audit.find_all_by_store_id(@stores)
      @saved_searches = current_user.save_searches.all
      
      if params[:search].nil?
        # search from current_user's scope  
        @photos = Photo.by_audits_in_stores(@stores, @env_types.map(&:id), @channels.map(&:id))
                  .where('category_id in (?) AND published = ?', @categories, true)
                            
      else 
        
        from_date = params[:search][:fromDate].present? ? params[:search][:fromDate] : DateTime.parse('01/01/1970')
        to_date = params[:search][:toDate].present? ? params[:search][:toDate] : DateTime.now
        @search_category = params[:search][:category] ? params[:search][:category] : @categories
        # @search_country = params[:search][:country_id] ? params[:search][:country_id] : @countries.map(&:id)
        @search_env_type = params[:search][:env_types].present? ? params[:search][:env_types] : @env_types.map(&:id)
        @search_channel = params[:search][:pchannel].present? ? params[:search][:pchannel] : @channels.map(&:id)
        
          @photos = Photo.by_audits_in_stores(@stores, @search_env_type, @search_channel)
          
          unless params[:search][:promo_cal]
            @photos = @photos.where('promotion_calendar_id IS NULL OR promotion_calendar_id IN (?)', @promo_calendars)
          else
            @photos = @photos.where('promotion_calendar_id IN (?)', params[:search][:promo_cal])
          end  
          unless params[:search][:promo_types]
            @photos = @photos.where('promotion_type_id IS NULL OR promotion_type_id IN (?)', @promo_types.map(&:id)) 
          else
            @photos = @photos.where('promotion_type_id IN (?)', params[:search][:promo_types]) 
          end  
          unless params[:search][:media_type]
            @photos = @photos.where('media_type_id IS NULL OR media_type_id IN (?)', @media_types.map(&:id)) 
          else
            @photos = @photos.where('media_type_id IN (?)', params[:search][:media_type]) 
          end
          unless params[:search][:media_v]
            @photos = @photos.where('media_vehicle_id IS NULL OR media_vehicle_id IN (?)', @media_vehicles.map(&:id)) 
          else
            @photos = @photos.where('media_vehicle_id IN (?)', params[:search][:media_v]) 
          end
          unless params[:search][:media_loc]
            @photos = @photos.where('media_location_id IS NULL OR media_location_id IN (?)', @media_locations.map(&:id)) 
          else
            @photos = @photos.where('media_location_id IN (?)', params[:search][:media_loc]) 
          end
          unless params[:search][:brands]
            @photos = @photos.where('brand_id IS NULL OR brand_id IN (?)', @brands.map(&:id)) 
          else
            @photos = @photos.where('brand_id IN (?)', params[:search][:brands]) 
          end
          unless params[:search][:themes]
            @photos = @photos.where('theme_id IS NULL OR theme_id IN (?)', @themes.map(&:id)) 
          else
            @photos = @photos.where('theme_id IN (?)', params[:search][:themes]) 
          end      

          @photos = @photos.where('photos.created_at >= (?) AND photos.created_at <= (?) AND category_id IN (?) AND published = ?', 
            from_date, to_date, @search_category, true )
          
        sleep 2
      end


    elsif user_is_country_subscriber?
      

    elsif user_is_category_subscriber?
      
      
    else 
      # SOMETHING ELSE

    end

    # MAP
    
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

  def get_photo
    
    #asset = Photo.find(params[:photo_ids])
    asset = Photo.find_by_id(12)
    # download_zip(asset)
    # input_filenames = asset.photo_file_name
    # zipfile_name = "archive.zip"
    # debugger
    #send_file asset.photo.url(:medium), :type => asset.photo_content_type
    # Zip::ZipFile.open(zipfile_name, Zip::ZipFile::CREATE) do |zipfile|
      #input_filenames.each do |filename|
      # Two arguments:
      # - The name of the file as it will appear in the archive
      # - The original file, including the path to find it
      # zipfile.add(input_filenames, asset.photo.url(:medium))
      #end
    # end

    redirect_to asset.photo.url(:medium)
    #openall_(asset.photo.url(:medium))
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
end
