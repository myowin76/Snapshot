class MediaVehiclesController < ApplicationController
  # GET /media_vehicles
  # GET /media_vehicles.json
  layout "admin"
  def index
    @media_vehicles = MediaVehicle.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @media_vehicles }
    end
  end

  # GET /media_vehicles/1
  # GET /media_vehicles/1.json
  def show
    @media_vehicle = MediaVehicle.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @media_vehicle }
    end
  end

  # GET /media_vehicles/new
  # GET /media_vehicles/new.json
  def new
    @media_vehicle = MediaVehicle.new

    respond_to do |format|
      format.html # new.html.erb
      format.js
      format.json { render json: @media_vehicle }
    end
  end

  # GET /media_vehicles/1/edit
  def edit
    @media_vehicle = MediaVehicle.find(params[:id])
  end

  # POST /media_vehicles
  # POST /media_vehicles.json
  def create
    @media_vehicle = MediaVehicle.new(params[:media_vehicle])

    respond_to do |format|
      if @media_vehicle.save
        format.html { redirect_to @media_vehicle, notice: 'Media vehicle was successfully created.' }
        format.js
        format.json { render json: @media_vehicle, status: :created, location: @media_vehicle }
      else
        format.html { render action: "new" }
        format.json { render json: @media_vehicle.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /media_vehicles/1
  # PUT /media_vehicles/1.json
  def update
    @media_vehicle = MediaVehicle.find(params[:id])

    respond_to do |format|
      if @media_vehicle.update_attributes(params[:media_vehicle])
        format.html { redirect_to @media_vehicle, notice: 'Media vehicle was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @media_vehicle.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /media_vehicles/1
  # DELETE /media_vehicles/1.json
  def destroy
    @media_vehicle = MediaVehicle.find(params[:id])
    @media_vehicle.destroy

    respond_to do |format|
      format.html { redirect_to media_vehicles_url }
      format.json { head :no_content }
    end
  end

  

end
