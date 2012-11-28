require 'csv'    

namespace :photos do
  task :import_csv => :environment do
  	
    CSV.foreach(File.join(Rails.root, 'bin', 'photos.csv')) do |row|
    	unless row.join.blank?


    		
	    	unless row[0].blank?
	    		file_name = row[0]
		    	puts file_name
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
				unless row[5].blank?
				  promotion_cal = PromotionCalendar.find_by_name(row[5]) rescue nil
				  puts promotion_cal.id
				end
			  unless row[6].blank?
				  description = row[6]
			  	puts description
			  end
			  unless row[7].blank?	
				  headline = row[7]
				  puts headline
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
			  
	    end
		end
  end
end
