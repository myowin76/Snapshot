require 'csv'    

namespace :photos do
  task :import_csv => :environment do
  	
    CSV.foreach(File.join(Rails.root, 'bin', 'photos.csv')) do |row|
    	unless row.join.blank?

    		# headline
    		unless row[20].blank?	
				  headline = row[20]
				end
				
				# description
				unless row[19].blank?	
				  description = row[19]
				end
				
				# promotion calendar
				unless row[18].blank?
		   		@promotion_cal = PromotionCalendar.find_by_name(row[18])
		   		if @promotion_cal.nil?
		   			@promotion_cal = PromotionCalendar.new(:name => row[18])
		   		end
		   	end

		   	# category
	    	unless row[17].blank?
	    		row[17].to_s.split(",").each do |cat|
		    		@category = Category.find_by_name(row[17])
			   		if @category.nil?
			   			@category = Category.new(:name => row[17])
			   		end
			   	end
		    end

		    unless row[2].blank?
	    		additional_brands = row[2]
		    	puts additional_brands
		    end	
		    unless row[1].blank?
		    	brand = Brand.find_by_name(row[1])
		    	puts brand.id
		    end
	    	unless row[3].blank?
		    	brand_owner = BrandOwner.find_by_name(row[3])
		    	puts brand_owner.id
	    	end
	    	unless row[4].blank?
		    	category = Category.find_by_name(row[4]) rescue nil #unless row[6].blank?
				  puts category.id
				end
				
			  unless row[6].blank?
				  description = row[6]
			  	puts description
			  end
			  
			  unless row[8].blank?
				  media_location = MediaLocation.find_by_name(row[8])
				  puts media_location.id
				end

				unless row[9].blank?  
			  	media_vehicle = MediaVehicle.find_by_name(row[9])
				  puts media_vehicle.id
				end
				unless row[10].blank?  
				  media_type = MediaType.find_by_name(row[10])
				  puts media_type.id
				end
			  unless row[11].blank?
				  promotion_type = PromotionType.find_by_name(row[11])
				  puts promotion_type.id
				end  
			 #  unless row[13].blank?
				#   theme = Theme.find_by_name(row[13])
				#   puts theme.id
				# end  


				unless row[4].blank?
		   		@photo = Photo.find_by_name(row[4])
		   		# TO CREATE AUDIT
		   		
		   		if @photo.nil?
		   			Dir.glob(File.join(Rails.root, 'bin', 'test', '*')) do |content|

							File.open(content) do |f|
								photo = Photo.new
					      photo.photo = f # just assign the logo attribute to a file
					      if photo.save
					      	puts photo.photo_file_name
					      else
					      		
					      end
					    end #file gets closed automatically here
						end



		   				# @store = Store.new(:name => row[4])
		   				Photo.create(
						  	#:id => row[0],
						  	:retailer_id => @retailer.id,
						  	:name => row[1],
						  	:address => row[2],
						  	:address2 => row[3],
						  	:address3 => row[2],
						  	:town => row[3],
						  	:postcode => row[4],
						  	:store_format_id => @store_format.id,
						  	
						  	:country_id => @country.id,
						  	:longitude => row[8],
						  	:latitude => row[9],
						  	:description => row[10],
						  	:created_at => Time.now,
						  	:updated_at => Time.now,
						  	:location_id => 1
					  	)

		   		else

		   		end
		   	end

			  
	    end
		end
  end
end
