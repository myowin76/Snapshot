class AuditsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_user, :only => [:index,:new,:edit]
  before_filter :accessible_roles, :only => [:new, :edit, :show, :update, :create]
  load_and_authorize_resource # :only => [:show,:new,:destroy,:edit,:update]

  layout "admin"

  def index

    # @retailers = Retailer.all
    # if admin_user?
    # @audits = Audit.order(:created_at)
    # elsif uploader?
    #   @audits = current_user.audits.all
    # elsif subscriber?
    # else
    #   @audits = current_user.audits.all
    # end  

    unless params[:store_id].nil?
      store = Store.find_by_id(params[:store_id])
      @audits = store.audits.order(:created_at)
    else
      @audits = Audit.order(:created_at)
    end




    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @audits }
    end
  end
  
  def show
    @audit = Audit.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @audit }
    end
  end

  def new
    @audit = Audit.new
    @retailers = Retailer.all
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @audit }
    end
  end

  def edit
    
    @audit = Audit.find(params[:id])
    if @audit.store
      @store = @audit.store  
    end  
    @retailers = Retailer.order(:name).all
    
  end

  def create
    
    @audit = Audit.new(params[:audit])
    
    if params[:audit].present? && params[:audit][:store_id].blank?
      redirect_to new_audit_path, notice: 'Please fill require data.'
    elsif params[:store_id].present? || params[:audit][:store_id].present?
    # else
      respond_to do |format|
        if @audit.save
          
          @audit.update_attribute(:user_id, current_user.id)
          if params[:audit].present? && params[:audit][:store_id].present?
            @audit.update_attribute(:store_id, params[:audit][:store_id])
          elsif params[:store_id].present?
            @audit.update_attribute(:store_id, params[:store_id])
          end  
          
          format.html { redirect_to @audit, notice: 'Audit was successfully created.' }
          format.json { render json: @audit, status: :created, location: @audit }
        else
          format.html { render action: "new" }
          format.json { render json: @audit.errors, status: :unprocessable_entity }
        end
      end 
    end
  end

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
    
    if params[:audit_retailer_id].present?
      @stores = Store.find_all_by_retailer_id(params[:audit_retailer_id])  
    else  
    
    end  
      
    respond_to do |format|
      format.js {
        render :partial => 'refresh_store_dropdown', :locals => { :stores => @stores}
      }
    end
  end

end
