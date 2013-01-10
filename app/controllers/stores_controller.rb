class StoresController < ApplicationController
  layout "admin", :only => :index 
  def index

    if user_is_country_and_category_subscriber?
      
      @countries = Country.find(current_user.subscription.sub_country.split(","))
      # @stores_in_country = Store.find_all_by_country_id(@countries)
      @categories = Category.find(current_user.subscription.sub_cats.split(","))
      @stores_in_country = Store.order(:name).where('country_id IN (?)', @countries)
      # @stores = Store.all

    elsif user_is_country_subscriber?
      

    elsif user_is_category_subscriber?
      
    else 
      # SOMETHING ELSE
      # @subscribed_country = "none"
    end

    respond_to do |format|
      format.html # index.html.erb
      format.csv { send_data @stores_in_country.to_csv }
      format.xls  { send_data @stores_in_country.to_csv(col_sep: "\t") }
      format.json { render json: @stores_in_country }
      # format.csv { render text: @stores_in_country.to_csv }
      
    end
  end

  def show
    # @selected_categories = params[categories] from search page

    @store = Store.find(params[:id])
    
    # @audits = @store.audits.order('created_at DESC')
    # @audit = @audits.first
    # @store = Store.find_by_id(params[:store_id])
      @audits = @store.audits.order('created_at DESC')
      @audit = @audits.first

      if params[:categories]
        @selected_categories = Category.find_all_by_id(params[:categories].split(","))
        @photo_categories = Category.joins(:photos).includes(:categorizations)
          .where('photos.audit_id IN (?)', @audit.id)
          .where("category_id in (?)", @selected_categories.map(&:id))
          .group("categories.id");
      else
        @selected_categories = Category.joins(:photos).
          where('photos.audit_id IN (?)', @audit.id)
        @photo_categories = Category.joins(:photos).includes(:categorizations)
          .where("category_id in (?)", @selected_categories.map(&:id))
          .group("categories.id");
      end
        
    respond_to do |format|
      # format.html # show.html.erb
      format.js{
        render :partial => 'show_store_with_categories', :locals => { :store => @store }
      }
      # format.json { render json: @store }
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

  def refresh_store_view_categories
    # When user select between audits in select boxes
    # the categories of the selected audits need to refresh
    @store = Store.find_by_id(params[:store_id])
    if params[:audit_id]
      @audit = Audit.find_by_id(params[:audit_id])
    else
      @audits = @store.audits.order('created_at DESC')
      @audit = @audits.first
    end  

      unless params[:categories].blank?

        @selected_categories = Category.find_all_by_id(params[:categories].split(","))
        
        # @photo_categories = @selected_categories

        @photo_categories = Category.joins(:photos).includes(:categorizations)
        .where('photos.audit_id IN (?)', @audit.id)
        .where("category_id in (?)", @selected_categories.map(&:id))
        .group("categories.id");
          
          
          
          
      else
        @selected_categories = Category.joins(:photos)
        .where('photos.audit_id IN (?)', @audit.id)

        @photo_categories = Category.joins(:photos).includes(:categorizations)
          .where("category_id in (?)", @selected_categories.map(&:id))
          .group("categories.id");
          
      end

    
    # if params[:audit_id]
      
      # @audit = Audit.find_by_id(params[:audit_id])
      # if params[:categories]
      #   @selected_categories = Category.find_all_by_id(params[:categories])
      # else
      #   @selected_categories = Category.order(:name)  
      # end
      # @categories = Category.find_all_by_id(params[:checked_category_ids])
      # @photos_in_category = Photo.where('')

      # debugger
      respond_to do |format|
        format.js {
          render :partial => 'stores/refresh_store_view_categories', :locals => { :audit => @audit }
        }
      end
    # end  
  end

  def show_store_with_categories

    if params[:store_id]  
      @store = Store.find_by_id(params[:store_id])
      @audits = @store.audits.order('created_at DESC')
      @audit = @audits.first

      if params[:categories]
        @selected_categories = Category.find_all_by_id(params[:categories].split(","))
        @photo_categories = Category.joins(:photos).includes(:categorizations)
          .where('photos.audit_id IN (?)', @audit.id)
          .where("category_id in (?)", @selected_categories.map(&:id))
          .group("categories.id");
      else
        @selected_categories = Category.joins(:photos).
          where('photos.audit_id IN (?)', @audit.id)
        @photo_categories = Category.joins(:photos).includes(:categorizations)
          .where("category_id in (?)", @selected_categories.map(&:id))
          .group("categories.id");
      end
      # .having("count(photo_id)");
      
      respond_to do |format|
        # format.json { render json: @store }
        format.js{
          render :partial => 'show_store_with_categories', :locals => { :store => @store }
        }
      end
    end
  end

  def get_store_details
    # New Audit form
    
    unless params[:audit][:store_id].nil?
      @store = Store.find_by_id(params[:audit][:store_id])
    
      respond_to do |format|
        format.js {
          render :partial => 'stores/show_details', :locals => { :store => @store }
        }
      end
    end  
  end

end
