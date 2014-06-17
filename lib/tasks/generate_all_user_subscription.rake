# heroku run rake check_db:updates
namespace :generate do
  task :user_subscription => :environment do

  	@users = User.all
  	@users.each do |user|
  		unless user.subscription.present?
  			user.create_subscription
  		end	
  	end

  end
end
