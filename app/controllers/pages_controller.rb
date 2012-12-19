class PagesController < ApplicationController
  layout "admin"  
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
		@unpublished_photos = Photo.unpublished  
  end
end
