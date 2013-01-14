class BrandOwnersController < ApplicationController
  before_filter :authenticate_user!
  layout 'admin'
  def index
    @brand_owners = BrandOwner.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @brand_owners }
    end
  end

  # GET /brand_owners/1
  # GET /brand_owners/1.json
  def show
    @brand_owner = BrandOwner.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @brand_owner }
    end
  end

  # GET /brand_owners/new
  # GET /brand_owners/new.json
  def new
    @brand_owner = BrandOwner.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @brand_owner }
    end
  end

  # GET /brand_owners/1/edit
  def edit
    @brand_owner = BrandOwner.find(params[:id])
  end

  # POST /brand_owners
  # POST /brand_owners.json
  def create
    @brand_owner = BrandOwner.new(params[:brand_owner])

    respond_to do |format|
      if @brand_owner.save
        format.html { redirect_to new_brand_owner_path, notice: 'Brand owner was successfully created.' }
        format.json { render json: @brand_owner, status: :created, location: @brand_owner }
      else
        format.html { render action: "new" }
        format.json { render json: @brand_owner.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /brand_owners/1
  # PUT /brand_owners/1.json
  def update
    @brand_owner = BrandOwner.find(params[:id])

    respond_to do |format|
      if @brand_owner.update_attributes(params[:brand_owner])
        format.html { redirect_to @brand_owner, notice: 'Brand owner was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @brand_owner.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /brand_owners/1
  # DELETE /brand_owners/1.json
  def destroy
    @brand_owner = BrandOwner.find(params[:id])
    @brand_owner.destroy

    respond_to do |format|
      format.html { redirect_to brand_owners_url }
      format.json { head :no_content }
    end
  end
end
