class StoresController < ApplicationController
  # GET /stores
  # GET /stores.json


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

  # GET /stores/1
  # GET /stores/1.json
  def show
    @store = Store.find(params[:id])
    
    #@user_categories = Category.find(current_user.sub_cats.split(","))
    @photos = Photo.joins(:audit).where('audits.store_id = ?', @store.id)
    
    
    @photo_category = @photos.group_by { |c| c.category.id }
    # @photo_category = @photos.group_by(@categories)
    debugger
    # @photo_category = @photos.group(&:categories)
    # @categories = Category.find(current_user.subscription.sub_cats.split(","))

    # debugger

    # debugger
    
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
