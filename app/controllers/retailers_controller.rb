class RetailersController < ApplicationController
  before_filter :authenticate_user!
  
  layout "admin"
  def index
    @retailers = Retailer.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml { render xml: @retailers }
      format.json { render json: @retailers }
    end
  end

  # GET /retailers/1
  # GET /retailers/1.json
  def show
    @retailer = Retailer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @retailer }
    end
  end

  # GET /retailers/new
  # GET /retailers/new.json
  def new
    @retailer = Retailer.new
    @sectors = Sector.all
    # redirect_back_or_default
    respond_to do |format|
      format.html # new.html.erb
      format.js
      format.json { render json: @retailer }
    end
  end

  # GET /retailers/1/edit
  def edit
    @retailer = Retailer.find(params[:id])
    
  end

  # POST /retailers
  # POST /retailers.json
  def create
    @retailer = Retailer.new(params[:retailer])
    
    respond_to do |format|
      if @retailer.save
        # debugger
        # redirect_back_or_default @retailer
        format.js
        format.html { redirect_to @retailer, notice: 'Retailer was successfully created.' }
        format.json { render json: @retailer, status: :created, location: @retailer }
      else
        format.js
        format.html { render action: "new" }
        format.json { render json: @retailer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /retailers/1
  # PUT /retailers/1.json
  def update
    @retailer = Retailer.find(params[:id])
debugger
    respond_to do |format|
      if @retailer.update_attributes(params[:retailer])
        format.html { redirect_to @retailer, notice: 'Retailer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @retailer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /retailers/1
  # DELETE /retailers/1.json
  def destroy
    @retailer = Retailer.find(params[:id])
    @retailer.destroy

    respond_to do |format|
      format.html { redirect_to retailers_url }
      format.json { head :no_content }
    end
  end
end
