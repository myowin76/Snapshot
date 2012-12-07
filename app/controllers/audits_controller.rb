class AuditsController < ApplicationController
  # GET /audits
  # GET /audits.json
  layout "admin"

  def index
    @retailers = Retailer.all
    if admin_user?
      @audits = Audit.all
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
    debugger    
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

    respond_to do |format|
      if @audit.save
        # save user
        @audit.update_attribute(:user_id, current_user.id)
         
        if @audit.photos.blank?
          format.html { redirect_to edit_audit_path(@audit), notice: 'Please upload images.' }
        else
          format.html { redirect_to edit_audit_path(@audit), notice: 'Audit was successfully created.' }
        end
        format.json { render json: @audit, status: :created, location: @audit }
      else
        format.html { render action: "new" }
        format.json { render json: @audit.errors, status: :unprocessable_entity }
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
        format.html { redirect_to audits_path, notice: 'Audit was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @audit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /audits/1
  # DELETE /audits/1.json
  def destroy
    @audit = Audit.find(params[:id])
    @audit.destroy

    respond_to do |format|
      format.html { redirect_to audits_url }
      format.json { head :no_content }
    end
  end
end
