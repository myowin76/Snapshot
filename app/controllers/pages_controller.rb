class PagesController < ApplicationController
  def home

  	@channels = Channel.all
  	@categories = Category.all
  	
  end

  def contact
  end
end
