# require 'csv'    

# namespace :stores do
#   task :import_stores => :environment do

#     CSV.foreach(File.join(Rails.root, 'bin', 'stores.csv')) do |row|
# 		  unless row.join.blank?
# 			  # cells map
# 			  retailer_cell = row[2]
# 			  sector_cell = row[2]
# 			  store_format_cell = row[2]
# 			  env_type_cell = row[2]
# 			  channel_cell = row[2]
# 			  store_name_cell = row[2]
# 			  country_cell = row[3]
# 			  address_cell = row[2]
# 			  address2_cell = row[2]
# 			  address3_cell = row[2]
# 			  town_cell = row[2]
# 			  postcode_cell = row[2]
# 			  desc_cell = row[4]

# 		   	################ Retailer and Sector Process ###########################
# 				unless retailer_cell.blank?
# 		   		@retailer = Retailer.find_by_name(retailer_cell) #rescue nil#unless row[5].blank?
		   		
# 		   		unless @retailer.nil?
# 		   			@sector = @retailer.sector

# 		   		else
# 		   			@sector = Sector.find_by_name(sector_cell)
# 		   			if @sector.nil?
# 		   				@sector = Sector.new(:name => sector_cell)
# 		   				@sector.save
# 		   			end
# 		   		end
# 		   		# create retailer with sector	
# 		   		@retailer = Retailer.new(:name => retailer_cell, :sector_id => @sector.id)
# 		   		@retailer.save
		   		
# 		   	end 
# 		   	################ Store Format Process ###########################

# 				unless store_format_cell.blank?
# 		   		@store_format = StoreFormat.find_by_name(store_format_cell))
# 		   		if @store_format.nil?
# 		   			@store_format = StoreFormat.new(:name => store_format_cell)
# 		   		end
# 		   	end

# 		   	################ Environment Type Process ###########################

# 				unless env_type_cell.blank?
# 		   		@env_type = EnvironmentType.find_by_name(env_type_cell)

# 		   		if @env_type.nil?
# 		   			@env_type = EnvironmentType.new(:name => env_type_cell)
# 		   		end
# 		   	end

# 		   	################ Channel Process ###########################

# 				unless channel_cell.blank?
# 		   		@channel = Channel.find_by_name(channel_cell) #rescue nil#unless row[5].blank?
# 		   		if @channel.nil?
# 		   			@channel = Channel.new(:name => channel_cell)
# 		   		end
# 		   	end

# 		   	################ Country Process ###########################
# 		   	unless country_cell.blank?
# 		   		@country = Country.find_by_name(country_cell) 
# 		   		if @country.nil?
# 		   			@country = Country.new(:name => country_cell)
# 		   		end
# 		   	end

			  
# 		   	#####  CHECK IF NEW STORE RECORD ######
# 			  unless store_name_cell.blank?
# 		   		@store = Store.find_by_name(store_name_cell)
		   		
# 		   		unless @store.present?
# 		   				# @store = Store.new(:name => row[4])
# 		   				Store.create(
# 						  	#:id => row[0],
# 						  	:retailer_id => @retailer.id,
# 						  	:name => name_cell,
# 						  	:address => address_cell,
# 						  	:address2 => address2_cell,
# 						  	:address3 => address3_cell,
# 						  	:town => town_cell,
# 						  	:postcode => postcode_cell,
# 						  	:store_format_id => @store_format.id,
# 						  	:environment_type_id => @env_type.id,
# 						  	:channel_id => @channel.id,
# 						  	:country_id => @country.id,
# 						  	:longitude => row[8],
# 						  	:latitude => row[9],
# 						  	:description => desc_cell,
# 						  	:created_at => Time.now,
# 						  	:updated_at => Time.now,
# 						  	:location_id => 1
# 					  	)

# 		   		else

# 		   		end


# 			  #####  Audit Process ###### 		



# 		   	end


# 		   	# photos table
# 		   	# unless row[14].blank?
# 		   	# 	@photo = Photo.find_by_photo_file_name(row[14]) #rescue nil#unless row[5].blank?
# 		   	# 	if @photo.nil?
# 		   	# 		@photo = Photo.new(:photo_file_name => row[13])
# 		   	# 	end
# 		   	# end



# 			end # one row end
# 		end # csv end
#   end # task end
# end # namespace end


# # CSV.parse(File.join(Rails.root, 'bin', 'stores.csv')) do |row|
# #   n += 1
# #   # SKIP: header i.e. first row OR blank row
# #   next if n == 1 or row.join.blank?
# #   # build_from_csv method will map customer attributes & 
# #   # build new customer record
# #   store = Store.build_from_csv(row)
# #   # Save upon valid 
# #   # otherwise collect error records to export
# #   if customer.valid?
# #     customer.save
# #   else
# #     errs << row
# #   end
# # end
# # def build_from_csv(row)
# #     # find existing customer from email or create new
# #     cust = find_or_initialize_by_email(row[2])
# #     cust.attributes ={:first_name => row[0],
# #       :last_name => row[1],
# #       :email => row[3],
# #       :phone => row[4],
# #       :mobile => row[5],
# #       :address => row[6],
# #       :fax => row[7],
# #       :city => row[8]}
# #     return cust
# #   end