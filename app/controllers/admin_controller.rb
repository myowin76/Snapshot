class AdminController < ApplicationController
  # layout "admin", :only => "admin" 
  # layout false
  # before_filter :get_user, :only => [:admin, :home]
  # before_filter :accessible_roles, :only => [:admin]
  # load_and_authorize_resource :only => [:admin], :class => self.class
  load_and_authorize_resource :except => [:loginpage_message]
  # authorize_resource :class => false
  
  def home
	
  end

  def contact
  end
  
  def about
  end
  
  def news
  end
  
  def reports
  end

  def privacy
  end

  def raw_photos
    @unpublished_photos = Photo.order('photos.created_at DESC')
        .joins(:audit => [:user, :store => :retailer])
        .select("photos.*, users.username, retailers.name, stores.name")
        .unpublished.all
    render :layout => "admin"
  end

  def dashboard
    
		# @unpublished_photos = Photo.order('created_at DESC').unpublished.all
    render :layout => "admin"
  end

  def loginpage_message
    # layout false
    if params[:email].present? && params[:message].present?
      AdminMailer.loginpage_message(params).deliver
        
    else
      redirect_to "/users/sign_in?", :notice => "Please fill the required fields."
    end  
    
  end

end
