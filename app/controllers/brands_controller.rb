class BrandsController < ApplicationController
  before_filter :authenticate_user!
  layout "admin"
  def index
    @brands = Brand.order(:name)

    respond_to do |format|
      format.html # index.html.erb
      # format.json { render json: @brands }
      format.json { render json: @brands.tokens(params[:q]) }
    end
  end

  def show
    @brand = Brand.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @brand }
    end
  end

  def new
    @brand = Brand.new

    respond_to do |format|
      format.html # new.html.erb
      format.js
      format.json { render json: @brand }
    end
  end

  def edit
    @brand = Brand.find(params[:id])
  end

  def create
    @brand = Brand.new(params[:brand])

    respond_to do |format|
      if @brand.save
        format.html { redirect_to brands_path, notice: 'Brand was successfully created.' }
        format.json { render json: @brand, status: :created, location: @brand }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @brand.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @brand = Brand.find(params[:id])

    respond_to do |format|
      if @brand.update_attributes(params[:brand])
        format.html { redirect_to @brand, notice: 'Brand was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @brand.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @brand = Brand.find(params[:id])
    @brand.destroy

    respond_to do |format|
      format.html { redirect_to brands_url }
      format.json { head :no_content }
    end
  end
end
