namespace :audits do
  task :import_csv => :environment do
		require 'csv'     
    CSV.foreach(File.join(Rails.root, 'bin', 'photos.csv')) do |row|
		  unless row.join.blank?

				unless row[14].blank?
					postcode = row[14]
					puts postcode
					@store = Store.find(:first, :conditions => ['postcode = ?', postcode])
					puts @store.id
					
					unless row[14].blank?
						@env_type = EnvironmentType.find_by_name(row[14])
					end
					unless row[14].blank?
						@channel = Channel.find_by_name(row[14])
					end
					# if @store is not nil proceed to photo upload
					next if @store.nil?
					
					Audit.create!(
				  	:id => row[13],
				  	# :created_at => row[3]				
				  	:store_id => @store.id
				  	:environment_type_id => @env_type.id
				  	:channel_id => @channel.id
					)
				else
					# do something if audit id is not there	
				end 
			end
		end
  end
end