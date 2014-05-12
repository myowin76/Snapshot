class Users::RegistrationsController < Devise::RegistrationsController
# class RegistrationsConxtroller < Devise::RegistrationsController
  
  # before_filter :check_permissions, :only => [:create, :cancel]
  skip_before_filter :require_no_authentication
 
  def check_permissions
    authorize! :create, resource
  end

  protected
  def after_update_path_for(resource)
    
    if admin_user?
      user_path(resource)
    else
      root_path
    end
  end

end