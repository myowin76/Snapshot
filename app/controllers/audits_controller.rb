class AuditsController < ApplicationController
  # GET /audits
  # GET /audits.json
  layout "admin"

  def index
    @retailers = Retailer.all
    if admin_user?
      @audits = Audit.order(:created_at)
    # elsif uploader?
    #   @audits = current_user.audits.all
    # elsif subscriber?
    else
      @audits = current_user.audits.all
    end  

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @audits }
    end
  end

  # GET /audits/1
  # GET /audits/1.json
  def show
    @audit = Audit.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @audit }
    end
  end

  # GET /audits/new
  # GET /audits/new.json
  def new
    @audit = Audit.new
    @retailers = Retailer.all
    
    # @stores = Store.find_all_by_retailer_id(params[:id])
    # @audit.photos.build
    5.times{@audit.photos.build}
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @audit }
    end
  end

  # GET /audits/1/edit
  def edit
    
    @audit = Audit.find(params[:id])

    @store = @audit.store
    @retailers = Retailer.all
    5.times{@audit.photos.build}
  end

  # POST /audits
  # POST /audits.json
  def create
    @audit = Audit.new(params[:audit])
    if @audit.photos.blank?
      respond_to do |format|
        format.html { redirect_to new_audit_path, notice: 'Please select one or more images.' }
      end
    else
      respond_to do |format|
        if @audit.save
          # save user
          @audit.update_attribute(:user_id, current_user.id)
          
          format.html { redirect_to edit_audit_path(@audit), notice: 'Audit was successfully created.' }
          format.json { render json: @audit, status: :created, location: @audit }
        else
          format.html { render action: "new" }
          format.json { render json: @audit.errors, status: :unprocessable_entity }
        end
      end  
    end

    
  end

  # PUT /audits/1
  # PUT /audits/1.json
  def update
    @audit = Audit.find(params[:id])

    params[:photo_ids] ||= []    
    unless params[:photo_ids].empty?
      Photo.destroy_pics(params[:id], params[:photo_ids])
    end

    respond_to do |format|
      if @audit.update_attributes(params[:audit])
        format.html { redirect_to @audit, notice: 'Successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @audit.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @audit = Audit.find(params[:id])
    @audit.destroy

    respond_to do |format|
      format.html { redirect_to audits_url }
      format.json { head :no_content }
    end
  end

  def refresh_store_dropdown
    @stores = Store.find_all_by_retailer_id(params[:audit_retailer_id])
    
    respond_to do |format|
      format.js {
        render :partial => 'refresh_store_dropdown', :locals => { :stores => @stores}
      }
    end
    
  end
end
