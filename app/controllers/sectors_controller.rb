class SectorsController < ApplicationController
  before_filter :authenticate_user!
  layout "admin"
  def index
  
      @sectors = Sector.all

      # @sectors = Sector.search(params[:search])
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @sectors }
      end
  
  end
  def show
    @sector = Sector.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sector }
    end
  end

  def new
    @sector = Sector.new
  end

  def create
    @sector = Sector.new(params[:sector])
    if @sector.save
      redirect_to @sector, :notice => "Successfully created sector."
    else
      render :action => 'new'
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
