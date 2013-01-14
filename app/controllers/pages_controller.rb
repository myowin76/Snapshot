class PagesController < ApplicationController
  # layout "admin", :only => "admin" 
  layout false
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

  def admin
    layout "admin"
		@unpublished_photos = Photo.order('created_at DESC').unpublished.all
  end

  def loginpage_message
    
    # email = params[:email]
    # msg = params[:message]
    if params[:email].present? && params[:message].present?
      AdminMailer.loginpage_message(params).deliver
        
    else
      redirect_to "/users/sign_in?", :notice => "Please fill the required fields."
    end  
    
  end

end
