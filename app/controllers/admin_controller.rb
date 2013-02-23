class AdminController < ApplicationController
  # layout "admin", :only => "admin" 
  # layout false
  before_filter :get_user, :only => [:admin]
  before_filter :accessible_roles, :only => [:admin, :home]
  # load_and_authorize_resource :only => [:admin], :class => self.class
  authorize_resource :class => false
  
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

  def dashboard
    
		@unpublished_photos = Photo.order('created_at DESC').unpublished.all
    render :layout => "admin"
  end

  def loginpage_message
    
    if params[:email].present? && params[:message].present?
      AdminMailer.loginpage_message(params).deliver
        
    else
      redirect_to "/users/sign_in?", :notice => "Please fill the required fields."
    end  
    
  end

end
