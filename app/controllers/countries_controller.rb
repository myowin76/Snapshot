class CountriesController < ApplicationController
  before_filter :authenticate_user!
  layout "admin"
  
  def index
    @countries = Country.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml { render xml: @countries }
      format.json { render json: @countries }
    end
  end

  def show
    @country = Country.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @country }
    end
  end

  def new
    @country = Country.new
    respond_to do |format|
      format.html # new.html.erb
      format.js
      format.json { render json: @country }
    end
  end

  def create
    @country = Country.new(params[:country])
    if @country.save
      redirect_to @country, :notice => "Successfully created country."
    else
      render :action => 'new'
    end
  end

  def edit
    @country = Country.find(params[:id])
  end

  def update
    @country = Country.find(params[:id])
    if @country.update_attributes(params[:country])
      redirect_to @country, :notice  => "Successfully updated country."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @country = Country.find(params[:id])
    @country.destroy
    redirect_to countries_url, :notice => "Successfully destroyed country."
  end
end
