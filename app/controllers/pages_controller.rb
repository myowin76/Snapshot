class PagesController < ApplicationController
  def home

  	@channels = Channel.all
  	@categories = Category.all

  	@search = Photo.search(params[:q])
  	@photos = @search.result

  	
  end

  def contact
  end
end
