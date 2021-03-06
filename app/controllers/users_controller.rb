# class UsersController < ApplicationController
class UsersController < ApplicationController
  
  # include Devise::Controllers::Helpers
  before_filter :get_user, :only => [:index,:new,:edit]
  before_filter :accessible_roles, :only => [:new, :edit, :show, :update, :create]
  load_and_authorize_resource :only => [:index, :show, :new, :destroy, :edit, :update]
 
  layout "admin"
  def index
    # @users = User.accessible_by(current_ability, :index).limit(20)
    @users = User.accessible_by(current_ability, :index)

    respond_to do |format|
      format.json { render :json => @users }
      format.xml  { render :xml => @users }
      format.html
    end

  end

  def show
    respond_to do |format|
      format.json { render :json => @user }
      format.xml  { render :xml => @user }
      format.html      
    end
 
  rescue ActiveRecord::RecordNotFound
    respond_to_not_found(:json, :xml, :html)
  end
 
  def edit
    respond_to do |format|
      format.json { render :json => @user }   
      format.xml  { render :xml => @user }
      format.html
    end
 
  rescue ActiveRecord::RecordNotFound
    respond_to_not_found(:json, :xml, :html)
  end

  def new

    @user = User.new
    
    respond_to do |format|
      format.json { render :json => @user }   
      format.xml  { render :xml => @user }
      format.html
    end
    
  end

  def destroy
    # debugger
    @user = User.find(params[:id])
    @user.destroy

    redirect_to users_url, :notice => "User removed."
 
    # respond_to do |format|
    #   format.json { respond_to_destroy(:ajax) }
    #   format.xml  { head :ok }
    #   format.html { respond_to_destroy(:html) }      
    # end
 
  rescue ActiveRecord::RecordNotFound
    respond_to_not_found(:json, :xml, :html)
  end
 
  def create
    # debugger
    @user = User.new(params[:user])
    
 
    if @user.save
      respond_to do |format|
        format.json { render :json => @user.to_json, :status => 200 }
        format.xml  { head :ok }
        format.html { redirect_to :action => :index }
      end
    else
      respond_to do |format|
        format.json { render :text => "Could not create user", :status => :unprocessable_entity } # placeholder
        format.xml  { head :ok }
        format.html { render :action => :new, :status => :unprocessable_entity }
      end
    end
  end

  
   # Get roles accessible by the current user
  #----------------------------------------------------
  # def accessible_roles
  #   @accessible_roles = Role.accessible_by(current_ability,:read)
  # end
 
  # # Make the current user object available to views
  # #----------------------------------------
  # def get_user
  #   @current_user = current_user
  # end

   def update
   
    if params[:user][:password].blank?
      [:password,:password_confirmation,:current_password].collect{|p| params[:user].delete(p) }

    end
   # [:password,:password_confirmation,:current_password].collect{|p| params[:user].delete(p) }
    # if params[:user][:current_password].blank?
    #   [:password_confirmation,:current_password].collect{|p| params[:user].delete(p) }
    # end  
    # if params[:user][:password].blank?
    #   [:password,:password_confirmation,:current_password].collect{|p| params[:user].delete(p) }
    # # else
    # #   @user.errors[:base] << "The password you entered is incorrect" unless @user.valid_password?(params[:user][:current_password])
    #   password = params[:user][:password]
    #   @password = ::BCrypt::Password.create("#{password}#{pepper}", :cost => cost).to_s
    # end
 
    respond_to do |format|
      # if @user.errors[:base].empty? and @user.update_with_password(params[:user])
      #   flash[:notice] = "The account has been updated"
      #   format.json { render :json => @user.to_json, :status => 200 }
      #   format.xml  { head :ok }
      #   format.html { redirect_to :action => :index }
      @update_user = User.find_by_id(params[:id])
      
      if @user.errors[:base].empty? and @user.update_attributes(params[:user])
        
          @subscription = @update_user.subscription
          
          unless @subscription.nil?
            if !params[:subscription].nil? && params[:subscription][:category_ids].present?
              # @subscription.sub_cats = params[:subscription][:category_ids]
              @subscription.update_attribute(:sub_cats, params[:subscription][:category_ids].join(","))
            else
              @subscription.update_attribute(:sub_cats, nil)
            end

            if !params[:subscription].nil? && params[:subscription][:country_ids].present?
              @subscription.update_attribute(:sub_country, params[:subscription][:country_ids].join(","))
            else
              @subscription.update_attribute(:sub_country, nil)
            end

            if !params[:subscription].nil? && params[:subscription][:sector_ids].present?
              @subscription.update_attribute(:sectors, params[:subscription][:sector_ids].join(","))
            else
              @subscription.update_attribute(:sectors, nil)
            end

            if !params[:subscription].nil? && params[:subscription][:retailer_ids].present?
              @subscription.update_attribute(:retailers, params[:subscription][:retailer_ids].join(","))
            else
              @subscription.update_attribute(:retailers, nil)
            end

            if !params[:subscription].nil? && params[:subscription][:project_ids].present?
              @subscription.update_attribute(:projects, params[:subscription][:project_ids].join(","))
            else
              @subscription.update_attribute(:projects, nil)
            end
          end  

          # Subscription.update_subscription(@update_user, params[:subscriptions])
          # debugger
          flash[:notice] = "The account has been updated"
          format.html { redirect_to @update_user }
        


      else
        format.json { render :text => "Could not update user", :status => :unprocessable_entity } #placeholder
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
        format.html { render :action => :edit, :status => :unprocessable_entity }
      end
    end


 
  rescue ActiveRecord::RecordNotFound
    respond_to_not_found(:js, :xml, :html)
  end
  
end