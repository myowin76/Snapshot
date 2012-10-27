class MediaLocationsController < ApplicationController
  # GET /media_locations
  # GET /media_locations.json
  layout "admin"
  def index
    @media_locations = MediaLocation.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @media_locations }
    end
  end

  # GET /media_locations/1
  # GET /media_locations/1.json
  def show
    @media_location = MediaLocation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @media_location }
    end
  end

  # GET /media_locations/new
  # GET /media_locations/new.json
  def new
    @media_location = MediaLocation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @media_location }
    end
  end

  # GET /media_locations/1/edit
  def edit
    @media_location = MediaLocation.find(params[:id])
  end

  # POST /media_locations
  # POST /media_locations.json
  def create
    @media_location = MediaLocation.new(params[:media_location])

    respond_to do |format|
      if @media_location.save
        format.html { redirect_to @media_location, notice: 'Media location was successfully created.' }
        format.json { render json: @media_location, status: :created, location: @media_location }
      else
        format.html { render action: "new" }
        format.json { render json: @media_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /media_locations/1
  # PUT /media_locations/1.json
  def update
    @media_location = MediaLocation.find(params[:id])

    respond_to do |format|
      if @media_location.update_attributes(params[:media_location])
        format.html { redirect_to @media_location, notice: 'Media location was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @media_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /media_locations/1
  # DELETE /media_locations/1.json
  def destroy
    @media_location = MediaLocation.find(params[:id])
    @media_location.destroy

    respond_to do |format|
      format.html { redirect_to media_locations_url }
      format.json { head :no_content }
    end
  end
end
