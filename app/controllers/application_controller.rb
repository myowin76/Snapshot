class ApplicationController < ActionController::Base
  protect_from_forgery
   helper_method :subscribed_country
  before_filter :authenticate_user!
  def after_sign_in_path_for(resource)                                                                                                                      
      root_path                                                                                         
  end                                                                                                                                                     

  # need to fix doesn't work
  def subscribed_country
    return current_user.sub_country
  end

  protected
  def admin_user?
  	# return false if current_user.nil? || current_user.user_type.name != 'Admin'
  	true
  end
  
  def uploader?
  	# return false if current_user.nil? || current_user.user_type.name != 'Uploader'
  end

  def subscriber?
  	# return false if current_user.nil? || current_user.user_type.name != 'Subscriber'
    # find_by_countries_or_categories

  end

  


  def admin_or_uploader?(id)
  	if (admin_user? || uploader? )
  		return true
  	else
  		return false
  	end
  end

  def user_is_country_subscriber?
    return false if current_user.nil? || current_user.sub_country.blank?  || current_user.sub_country.nil?
    true
  end
  def user_is_category_subscriber?
    return false if current_user.nil? || current_user.sub_cats.blank?  || current_user.sub_cats.nil?
    true
  end
  def user_is_country_and_category_subscriber?
    if (user_is_country_subscriber? && user_is_category_subscriber? )
      return true
    else
      return false
    end
  end

end
