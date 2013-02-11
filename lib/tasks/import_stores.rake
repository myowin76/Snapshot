
# require 'smarter_csv'
# desc "Upload task from the csv file"
namespace :stores do
  task :import_stores => :environment do
    
		require 'csv'    
#     @rows = SmarterCSV.process(File.join(Rails.root, 'bin', 'stores.csv'))
# print @rows
    CSV.foreach(File.join(Rails.root, 'bin', 'stores.csv'), :headers => true) do |row|
		  unless row.join.blank?
			  # row = row.to_hash
				# next if n == 1 or row.join.blank?

		   	################ retailer and sector start ###########################
				unless row[1].blank?
		   		@retailer = Retailer.find_by_name(row[1]) #rescue nil#unless row[5].blank?
		   		
		   		unless @retailer.nil?
		   			@sector = @retailer.sector

		   		else
		   			@sector = Sector.find_by_name(row[2])
		   			if @sector.nil?
		   				@sector = Sector.new(:name => row[2])
		   				@sector.save
		   			end
		   		end
		   		# create retailer with sector	
		   		@retailer = Retailer.new(:name => row[1], :sector_id => @sector.id)
		   		@retailer.save
		   		
		   	end 
		   	################ retailer and sector end ###########################

		   	#check that store name already exist

				unless row[5].blank?
		   		@store_format = StoreFormat.find_by_name(row[5]) #rescue nil#unless row[5].blank?
		   		if @store_format.nil?
		   			@store_format = StoreFormat.new(row[5])
		   		end
		   	end

		   	unless row[6].blank?
		   		@retailer = Retailer.find_by_name(row[6]) #rescue nil#unless row[5].blank?
		   		if @retailer.nil?
		   			@retailer = Retailer.new(row[6])
		   		end
		   	end

		   	unless row[7].blank?
		   		@country = Country.find_by_name(row[7]) #rescue nil#unless row[5].blank?
		   		if @country.nil?
		   			@country = Country.new(row[7])
		   		end
		   	end



			  unless row[4].blank?
		   		@store = Store.find_by_name(row[4])
		   		
		   		if @store.nil?


		   				# @store = Store.new(:name => row[4])
		   				Store.create(
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


		   	# photos table
		   	unless row[14].blank?
		   		@photo = Photo.find_by_photo_file_name(row[14]) #rescue nil#unless row[5].blank?
		   		if @photo.nil?
		   			@photo = Photo.new(:photo_file_name => row[13])
		   		end
		   	end



			end # one row end
		end # csv end
  end # task end
end # namespace end


# CSV.parse(File.join(Rails.root, 'bin', 'stores.csv')) do |row|
#   n += 1
#   # SKIP: header i.e. first row OR blank row
#   next if n == 1 or row.join.blank?
#   # build_from_csv method will map customer attributes & 
#   # build new customer record
#   store = Store.build_from_csv(row)
#   # Save upon valid 
#   # otherwise collect error records to export
#   if customer.valid?
#     customer.save
#   else
#     errs << row
#   end
# end
# def build_from_csv(row)
#     # find existing customer from email or create new
#     cust = find_or_initialize_by_email(row[2])
#     cust.attributes ={:first_name => row[0],
#       :last_name => row[1],
#       :email => row[3],
#       :phone => row[4],
#       :mobile => row[5],
#       :address => row[6],
#       :fax => row[7],
#       :city => row[8]}
#     return cust
#   end