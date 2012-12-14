class PhotosController < ApplicationController
  def index
    
    if user_is_country_and_category_subscriber?
      
      @countries = Country.find(current_user.subscription.sub_country.split(","))
      # @categories = Category.order(:name)
      @categories = Category.find(current_user.subscription.sub_cats.split(","))
      # need to check category and country
      # @stores = Store.where('country_id IN (?)', @countries.map(&:id))
      @stores = Store.order(:id)
      @sectors = Sector.order(:name)
      @store_formats = StoreFormat.order(:name)
      
      unless params[:search].nil?
        # Country Search
        if params[:search][:country_id].present?
          # for selected country
          @stores = @stores.where('country_id IN (?)', params[:search][:country_id])
        else
          @stores = @stores.where('country_id IN (?) OR country_id IS NULL', @countries.map(&:id))
          
        end

        @stores = @stores.where('store_format_id IN (?)', params[:search][:sformats]) if params[:search][:sformats].present?
        # Location Search          
        @stores = @stores.near(params[:search][:location], 25, :order => :distance) if params[:search][:location].present?
        

        if params[:search][:sectors].present?
          @stores = @stores.joins(:retailer).where('retailers.sector_id IN (?)', params[:search][:sectors])
          @retailers = Retailer.find_all_by_sector_id(params[:search][:sectors])
        else
          @retailers = Retailer.joins(:stores).select("distinct(retailers.id), retailers.*").where("stores.country_id IN (?)", @countries) 
        end

        @stores = @stores.where('retailer_id IN (?)', params[:search][:retailers]) if params[:search][:retailers].present?
        
      else
        # page load
        @sectors = Sector.order(:name)
        @retailers = Retailer.joins(:stores).select("distinct(retailers.id), retailers.*").where("stores.country_id IN (?)", @countries)
        @stores = @stores.where('country_id IN (?) OR country_id IS NOT NULL', @countries.map(&:id))
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
      
      if params[:search].nil?
        # on page load
        @photos = []
          
      else 
        # search action
          from_date = params[:search][:fromDate].present? ? params[:search][:fromDate] : DateTime.parse('01/01/1970')
          to_date = params[:search][:toDate].present? ? params[:search][:toDate] : DateTime.now
          @search_env_type = params[:search][:env_types].present? ? params[:search][:env_types] : @env_types.map(&:id)
          @search_channel = params[:search][:pchannel].present? ? params[:search][:pchannel] : @channels.map(&:id)
          
          @photos = Photo.by_audits_in_stores(@stores, @search_env_type, @search_channel)
                    
            unless params[:search][:promo_types]
              # @photos = @photos.joins(:promotion_types).where('promotion_types.id IN (?) OR promotion_types.id IS NULL', @promo_types.map(&:id))
            else
              @photos = @photos.joins(:promotion_types).where('promotion_types.id IN (?)', params[:search][:promo_types])
            end  
            unless params[:search][:promo_cal]
              @photos = @photos.where('promotion_calendar_id IS NULL OR promotion_calendar_id IN (?)', @promo_calendars.map(&:id)) 
            else
              @photos = @photos.where('promotion_calendar_id IN (?)', params[:search][:promo_cal])
            end  
            
            unless params[:search][:media_type]
              # @photos = @photos.where('media_type_id IS NULL OR media_type_id IN (?)', @media_types.map(&:id)) 
            else
              # @photos = @photos.where('media_type_id IN (?)', params[:search][:media_type]) 
              @photos = @photos.joins(:media_types).where('media_types.id IN (?)', params[:search][:media_type])
            end
            unless params[:search][:media_v]
              # @photos = @photos.where('media_vehicle_id IS NULL OR media_vehicle_id IN (?)', @media_vehicles.map(&:id)) 
            else
              # @photos = @photos.where('media_vehicle_id IN (?)', params[:search][:media_v]) 
              @photos = @photos.joins(:media_vehicles).where('media_vehicles.id IN (?)', params[:search][:media_v])
            end
            unless params[:search][:media_loc]
              # @photos = @photos.where('media_location_id IS NULL OR media_location_id IN (?)', @media_locations.map(&:id)) 
            else
              # @photos = @photos.where('media_location_id IN (?)', params[:search][:media_loc]) 
              @photos = @photos.joins(:media_locations).where('media_locations.id IN (?)', params[:search][:media_loc])
            end
            unless params[:search][:brand_owners]
              # @photos = @photos.where('brand_id IS NULL OR brand_id IN (?)', @brands.map(&:id)) 
            else
              @brands_by_owners = @brands.find_all_by_brand_owner_id(params[:search][:brand_owners])
              @photos = @photos.joins(:brands).where('brands.id IN (?)', @brands_by_owners)
            end
            unless params[:search][:brands]
              # @photos = @photos.where('brand_id IS NULL OR brand_id IN (?)', @brands.map(&:id)) 
            else
              # @photos = @photos.where('brand_id IN (?)', params[:search][:brands]) 
              @photos = @photos.joins(:brands).where('brands.id IN (?)', params[:search][:brands])
            end
            unless params[:search][:themes]
              # @photos = @photos.where('theme_id IS NULL OR theme_id IN (?)', @themes.map(&:id)) 
            else
              # @photos = @photos.where('theme_id IN (?)', params[:search][:themes]) 
              @photos = @photos.joins(:themes).where('themes.id IN (?)', params[:search][:themes])
            end
            unless params[:search][:category]
              # @photos = @photos.where('theme_id IS NULL OR theme_id IN (?)', @themes.map(&:id)) 
            else
              # @photos = @photos.where('theme_id IN (?)', params[:search][:themes]) 
              @photos = @photos.joins(:categories).where('categories.id IN (?)', params[:search][:category])
            end            

            @photos = @photos.where('photos.created_at >= ? AND photos.created_at <= ?', 
              from_date, to_date)
            #.paginate(:page => params[:page], :per_page => 3)

            @photo_audits = @photos.select('DISTINCT audit_id').map(&:audit_id)
            @audits = Audit.find_all_by_id(@photo_audits)
            @store_ids = []
            @audits.each do |s|
              @store_ids.push(s.store_id)
            end
            
            @stores = @stores.where('stores.id IN (?)', @store_ids)
            @stores = @stores.where('stores.country_id IS NOT NULL')
            
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
    
  end
  def download_photos_as_zip # silly name but you get the idea
    generate_zip do |zipname, zip_path|
      File.open(zip_path, 'rb') do |zf|
        # you may need to set these to get the file to stream (if you care about that)
        # self.last_modified
        # self.etag
        # self.response.headers['Content-Length']
        self.response.headers['Content-Type'] = "application/zip"
        self.response.headers['Content-Disposition'] = "attachment; filename=#{zipname}"
        self.response.body = Enumerator.new do |out| # Enumerator is ruby 1.9
          while !zf.eof? do
            out << zf.read(4096)
          end
        end
      end
    end
  end


# def get_photo # silly name but you get the idea
#   photo = Photo.find_by_id(3201)
#   tmp_filename = "#{Rails.root}/tmp/" << Time.now.strftime('%Y-%m-%d-%H%M%S-%N').to_s << ".zip"
#   zip = Zip::ZipFile.open(tmp_filename, Zip::ZipFile::CREATE)
#   zip.close

#   # photos.each do |photo|
#     file_to_add = photo.photo_file_name
#     zip = Zip::ZipFile.open(tmp_filename)
    
#     zip.add("tmp/", photo.photo.url(:medium))
#     debugger
#     zip.close
#   # end
# end


# Zipfile generator


  def get_photo
    
    asset = Photo.find(params[:id])
    # asset = Photo.find_by_id(3861)
    if asset
      data = open(URI.parse(URI.encode(asset.photo.url(:large))))
      temp_file = Tempfile.new("#{Rails.root}/tmp/export/" << "export".to_s << ".zip")

      Zip::ZipOutputStream.open(temp_file) do |zos|
        zos.put_next_entry(asset.photo_file_name)
        zos.print IO.read(data)
      end

      send_file temp_file, :type => 'application/zip', :disposition => 'attachment', :filename => "export"
      
      # redirect_to asset.photo.url(:medium)
      temp_file.close
      
    end
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
  # def save_search
  #   respond_to do |format|
  #     format.html  # index.html.erb
  #     format.json { 
  #       #render json: @photos 
  #     }
  #     format.js
  #   end
  # end

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