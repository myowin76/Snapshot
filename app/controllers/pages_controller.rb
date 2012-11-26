class PagesController < ApplicationController
  layout "admin"  
  def home

  	
  end

  def contact
  end
  def admin
		@unpublished_photos = Photo.unpublished  
  end
end
