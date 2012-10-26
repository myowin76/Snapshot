class PhotosController < ApplicationController
  # GET /photos
  # GET /photos.json
  def index
    
    # NEED TO CHECK WHEN PAGE LOAD, AGAINST USER SUBSCRIPTIONS
    
    if user_is_country_subscriber?
      # TO CHECK ONLY COUNTRY/IES USER SUBSCRIBED
      @countries = Country.find(current_user.sub_country.split(","))
      @locations = Location.find_all_by_country_id(@countries)
      # if not post request with params(first load), find all photos OR with limit amount
      # find all categories in the country
      
      # FIND ONLY STORES IN THE COUNTRY, BY LOCATION/COUNTRY
      # @stores_in_country = Store.find(:all).map(&:id)
      # @stores_in_country = Store.find_all_by_location_id(@locations)
      @stores_in_country = Store.find_all_by_country_id(@countries)
      
      #@retailers_in_country = Retailer.find_all_by_id(@store_in_country, :select => 'DISTINCT id', :order => 'name')
      @retailers_in_country = Retailer.all
      @audits_in_country = Audit.find_all_by_store_id(@stores_in_country)
      
      @categories = Category.all
      @photos = Photo.find_all_by_audit_id(@audits_in_country)          

    elsif user_is_category_subscriber?
      @countries = Country.all
      @categories = Category.find(current_user.sub_cats.split(","))
      
      @photos = Photo.find_all_by_category_id(@categories)          

      
    elsif user_is_country_and_category_subscriber?

    
    else 
      # SOMETHING ELSE
      # @subscribed_country = "none"
    end
      
    @sectors = Sector.all
    @stores = Store.all
    @channels = Channel.all
    @environment_types = EnvironmentType.all
    if params[:category]

    
    else
      #@photos = Photo.all
    end

    #@photos = Photo.search(params[:search])    
    
    #@countries = Country.all

    @locations = Location.all
    @retailers = Retailer.all
    
    @sectors = Sector.all
    @promo_calendar = PromotionCalendar.all
    #@stores = Store.search(params[:search])
    # ransack syntax
    #@search = Photo.search(params[:q])
    
    

    # need to filter by search
    @json = Store.all.to_gmaps4rails do |store, marker|
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
      format.json { render json: @photos }
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
