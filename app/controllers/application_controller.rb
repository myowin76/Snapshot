class ApplicationController < ActionController::Base
  protect_from_forgery
  #before_filter :authenticate
  helper_method :subscribed_country, :admin_user?, :uploader?, :admin_or_uploader?
  
  # before_filter :authenticate_user!

  layout :layout_by_resource

  def authenticate
    if request.format == "application/json"
      authenticate_or_request_with_http_basic do |username, password|
          username == "foo" && password == "bar"
      end
      # debugger
      warden.custom_failure! if performed?
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end

  def accessible_roles
    @accessible_roles = Role.accessible_by(current_ability,:read)
  end
 
  # Make the current user object available to views
  #----------------------------------------
  def get_user
    @current_user = current_user
  end

  def after_sign_in_path_for(resource)

      root_path
      # resource.reset_authentication_token
  end                                                                                                                                                     
  
  def check_return_url
      store_location
  end

  def store_location
    session[:return_to] = request.env['REQUEST_URI']
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
  # need to review below
  # need to fix doesn't work
  def subscribed_country
    return current_user.sub_country
  end
  

  protected

  def layout_by_resource
    if devise_controller?
      "sign_in"
    else
      "application"
    end
  end

  def admin_user?
  	 return false if current_user.nil? || current_user.user_type.name != 'Admin'
  	true
  end
  
  def uploader?
  	return false if current_user.nil? || current_user.user_type.name != 'Uploader'
    true
  end

  def subscriber?
  	# return false if current_user.nil? || current_user.user_type.name != 'Subscriber'
    # find_by_countries_or_categories

  end

  def admin_or_uploader?
  	if ( admin_user? || uploader? )
  		return true
  	else
  		return false
  	end
  end

  def user_is_country_subscriber?
    if current_user.subscription.nil?
      return false
    else  
      return false if current_user.nil? || current_user.subscription.sub_country.blank?  || current_user.subscription.sub_country.nil?
      # return false if current_user.nil? || current_user.subscriptons.sub_country.blank?  || current_user.subscriptions.sub_country.nil?
      true
    end
  end
  def user_is_category_subscriber?
    # return false if current_user.nil?
    # debugger
    if current_user.subscription.nil?
      return false

    else  
      return false if current_user.nil? || current_user.subscription.sub_cats.blank?  || current_user.subscription.sub_cats.nil?
      true
    end
    

  end
  def user_is_sector_subscriber?
    if current_user.subscription.nil?
      return false
      
    else  
      return false if current_user.nil? || current_user.subscription.sectors.blank?  || current_user.subscription.sectors.nil?
      # return false if current_user.nil? || current_user.subscriptions.sub_cats.blank?  || current_user.subscriptions.sub_cats.nil?
      true
    end
  end

  def user_is_retailer_subscriber?
    if current_user.subscription.nil?
      return false
      
    else  
      return false if current_user.nil? || current_user.subscription.retailers.blank?  || current_user.subscription.retailers.nil?
      # return false if current_user.nil? || current_user.subscriptions.sub_cats.blank?  || current_user.subscriptions.sub_cats.nil?
      true
    end  
  end

  def user_is_country_and_category_subscriber?
    if (user_is_country_subscriber? && user_is_category_subscriber? )
      return true
    else
      return false
    end
  end

end