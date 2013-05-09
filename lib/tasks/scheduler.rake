# heroku run rake check_db:updates
namespace :check_db do
  task :updates => :environment do

  Setting.check_db_updates
  # NewsFeed.update
  # puts "done."
	end
end
