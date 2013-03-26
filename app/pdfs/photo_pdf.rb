class	PhotoPdf < Prawn::Document

	def initialize(photo)
		super()
		@photo = photo
		
		logo
		photo_details
		

	end

	def logo
		image open("#{Rails.root}/app/assets/images/SNAPSHOT_logo.jpg"), :width => 200	
		move_down(10)
	end
	
	def photo_image
		# text "File Name: #{@photo.photo_file_name}", :size => 14, :style => :bold
		image open("#{@photo.photo.url(:large)}"), :width => 450	
		# image open("#{@photo.photo.url(:medium).to_s.sub!(/\?.+\Z/, '')}")
	end

	def photo_details
		
			photo_image
			
			if @photo.audit.store

        data = [[ "Retailer","#{@photo.audit.store.retailer.name}"]]
        data += [[ "Retail Sector","#{@photo.audit.store.retailer.sector.name}"]]
        data += [[ "Store Name","#{@photo.audit.store.name}"]]
        
        if @photo.audit.store.address.present?
          address = "Address: #{@photo.audit.store.address}, "
        end
        if @photo.audit.store.address2.present?
          address = address +"#{@photo.audit.store.address2}, "
        end
        if @photo.audit.store.address3.present?
          address = address + "#{@photo.audit.store.address3}, "
        end
        if @photo.audit.store.town.present?
          address = address + "#{@photo.audit.store.town}, "
        end
        if @photo.audit.store.postcode.present?
          address = address + "#{@photo.audit.store.postcode}"
        end
        data += [[ "Address", address]]
        unless @photo.audit.store.country_id.nil?
          data += [[ "Country", "#{@photo.audit.store.country.name}" ]]
        end
        data += [[ "Store Format", "#{@photo.audit.store.store_format.name}" ]]
        data += [[ "Environment Type:", "#{@photo.audit.store.environment_type.name}" ]]
        if @photo.audit.store.channel.present?
          data += [[ "Channel","#{@photo.audit.store.channel.name}"]]
        end 
      end
  
      if @photo.categories.present?
        data += [[ "Categories","#{@photo.categories.map(&:name).join(", ")}"]]
      end
      if @photo.brands
          data += [[ "Brands", "#{@photo.brands.map(&:name).join(", ")}"]]
      end
      if @photo.promotion_calendar_id.present?
        data += [[ "Promotion Calendar", "#{@photo.promotion_calendar.name}"]]
      end  
      if @photo.promotion_types
          promotion_types = 
          data += [[ "Promotion Types", "#{@photo.promotion_types.map(&:name).join(", ")}"]]
      end
      if @photo.media_locations
        data += [[ "Promotion Types", "#{@photo.media_locations.map(&:name).join(", ")}"]]
      end
      if @photo.media_types
        data += [[ "Media Types", "#{@photo.media_types.map(&:name).join(", ")}"]]
      end   
      if @photo.media_vehicles
        data += [[ "Media Types", "#{@photo.media_vehicles.map(&:name).join(", ")}"]]
      end 

      table(data, :width => 450, :row_colors => ["FFFFFF", "FFFFCC"])
      move_down(20)
	end
end