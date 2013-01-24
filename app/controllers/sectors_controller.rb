class SectorsController < ApplicationController
  before_filter :authenticate_user!
  layout "admin"
  def index
  
      @sectors = Sector.all
      respond_to do |format|
        format.html # index.html.erb
        format.xml { render xml: @sectors }
        format.json { render json: @sectors }
      end
  end

  def show
    @sector = Sector.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render xml: @sector }
      format.json { render json: @sector }
    end
  end

  def new
    @sector = Sector.new
    respond_to do |format|
      format.html # new.html.erb
      format.js
      format.json { render json: @sector }
    end
  end

  def create
    @sector = Sector.new(params[:sector])
    respond_to do |format|
      if @sector.save
        format.html { redirect_to @sector, :notice => "Successfully created sector." }
        format.json { render json: @sector, status: :created, location: @sector }
      else
        format.html { render :action => 'new' }
      end
    end  
  end

  def edit
    @sector = Sector.find(params[:id])
  end

  def update
    @sector = Sector.find(params[:id])
    if @sector.update_attributes(params[:sector])
      format.html { redirect_to @sector, :notice  => "Successfully updated sector." }
      format.json { head :no_content }
    else
      format.html { render :action => 'edit' }
      format.json { render json: @sector.errors, status: :unprocessable_entity }
    end
  end

  def destroy
    @sector = Sector.find(params[:id])
    @sector.destroy
    redirect_to sectors_url, :notice => "Successfully destroyed sector."
  end
end
