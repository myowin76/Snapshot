class ApplicationController < ActionController::Base
  protect_from_forgery
  # helper_method :admin_user?, :uploader?, :subscriber?
  before_filter :authenticate_user!
  def after_sign_in_path_for(resource)                                                                                                                      
      root_path                                                                                         
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
  end

  def admin_or_uploader?(id)
  	if (admin_user? || uploader? )
  		return true
  	else
  		return false
  	end
  end

end
