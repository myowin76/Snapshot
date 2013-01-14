class PagesController < ApplicationController
  layout "admin", :only => "admin" 

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
		@unpublished_photos = Photo.order('created_at DESC').unpublished.all
  end

  def loginpage_message
    
    # email = params[:email]
    # msg = params[:message]
    AdminMailer.loginpage_message(params).deliver
    
  end

end
