class StoreFormatsController < ApplicationController
  # GET /store_formats
  # GET /store_formats.json
  before_filter :authenticate_user!
  layout "admin"
  def index
    @store_formats = StoreFormat.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @store_formats }
    end
  end

  # GET /store_formats/1
  # GET /store_formats/1.json
  def show
    @store_format = StoreFormat.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @store_format }
    end
  end

  # GET /store_formats/new
  # GET /store_formats/new.json
  def new
    @store_format = StoreFormat.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @store_format }
    end
  end

  # GET /store_formats/1/edit
  def edit
    @store_format = StoreFormat.find(params[:id])
  end

  # POST /store_formats
  # POST /store_formats.json
  def create
    @store_format = StoreFormat.new(params[:store_format])

    respond_to do |format|
      if @store_format.save
        format.html { redirect_to @store_format, notice: 'Store format was successfully created.' }
        format.json { render json: @store_format, status: :created, location: @store_format }
      else
        format.html { render action: "new" }
        format.json { render json: @store_format.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /store_formats/1
  # PUT /store_formats/1.json
  def update
    @store_format = StoreFormat.find(params[:id])

    respond_to do |format|
      if @store_format.update_attributes(params[:store_format])
        format.html { redirect_to @store_format, notice: 'Store format was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @store_format.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /store_formats/1
  # DELETE /store_formats/1.json
  def destroy
    @store_format = StoreFormat.find(params[:id])
    @store_format.destroy

    respond_to do |format|
      format.html { redirect_to store_formats_url }
      format.json { head :no_content }
    end
  end
end
