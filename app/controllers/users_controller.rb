class Users::SessionsController < Devise::SessionsController
	def index
		@user = User.new
	end
	def new
    super
  end

  def edit
    @user = User.find(params[:id])
  end
  def update
  	super
  	
  end
end