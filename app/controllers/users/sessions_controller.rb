class Users::SessionsController < Devise::SessionsController
  
  def create
    # debugger
    if params[:api_request]
        build_resource
        user_email = params[:email] || params[:user][:email]
        user_password = params[:password] || params[:user][:password]
        resource = User.find_for_database_authentication(:email => user_email)
        return invalid_login_attempt unless resource

        if resource.valid_password?(user_password)
    	    resource.ensure_authentication_token!  #make sure the user has a token generated
    	    render :json => { :authentication_token => resource.authentication_token, :user_id => resource.id }, :status => :created
    	    return
    	end
    else
        super
    end

  end

	# def destroy
 #    # expire auth token
 #    @user=User.where(:authentication_token=>params[:auth_token]).first
 #    @user.reset_authentication_token!
 #    render :json => { :message => ["Session deleted."] },  :success => true, :status => :ok
	# end

	def invalid_login_attempt
    warden.custom_failure!
    render :json => { :errors => ["Invalid email or password."] },  :success => false, :status => :unauthorized
	end
end