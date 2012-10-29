class StoresController < ApplicationController
  # GET /stores
  # GET /stores.json
  
  def index
    
    
    # START -- DETAULT PAGE LOAD
    #@stores = Store.all
    if user_is_country_and_category_subscriber?
      @retailers= Retailer.all
      @countries = Country.find(current_user.sub_country.split(","))
      @stores_in_country = Store.find_all_by_country_id(@countries)
      @audits_in_country = Audit.find_all_by_store_id(@stores_in_country)
      @categories = Category.find(current_user.sub_cats.split(","))
      @photos = Photo.find(:all, :conditions => ["audit_id in (?) AND category_id in (?)", @audits_in_country, @categories])                

    elsif user_is_country_subscriber?
      # TO CHECK ONLY COUNTRY/IES USER SUBSCRIBED
      @countries = Country.find(current_user.sub_country.split(","))
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

    @locations = Location.find_all_by_country_id(@countries)
    @retailers = Retailer.all
    @promo_calendar = PromotionCalendar.all

    # MAP DATA
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

  # END -- DETAULT PAGE LOAD

  # START -- IF SEARCH PARAMS EXITST
    

  # END -- IF SEARCH PARAMS EXITST




    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stores }
    end
  end

  # GET /stores/1
  # GET /stores/1.json
  def show
    @store = Store.find(params[:id])
    @audits = @store.audits.find_all
    @audits.each do |audit|
      @photos = audit.photos.find(:all, :order => 'category_id, id')
      @photo_category = @photos.group_by { |c| c.category.id }
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @store }
    end
  end

  # GET /stores/new
  # GET /stores/new.json
  def new
    @store = Store.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @store }
    end
  end

  # GET /stores/1/edit
  def edit
    @store = Store.find(params[:id])
  end

  # POST /stores
  # POST /stores.json
  def create
    @store = Store.new(params[:store])

    respond_to do |format|
      if @store.save
        format.html { redirect_to @store, notice: 'Store was successfully created.' }
        format.json { render json: @store, status: :created, location: @store }
      else
        format.html { render action: "new" }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /stores/1
  # PUT /stores/1.json
  def update
    @store = Store.find(params[:id])

    respond_to do |format|
      if @store.update_attributes(params[:store])
        format.html { redirect_to @store, notice: 'Store was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stores/1
  # DELETE /stores/1.json
  def destroy
    @store = Store.find(params[:id])
    @store.destroy

    respond_to do |format|
      format.html { redirect_to stores_url }
      format.json { head :no_content }
    end
  end
end
