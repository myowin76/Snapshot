class	PhotoListPdf < Prawn::Document
	def initialize(photos)
		
		# super(:page_layout => :landscape, :page_size => "A4", :margin => [60,40])
    super(:page_size => "A4", :margin => [60,40])
		font "Helvetica", :size => 10
		
		photo_ids = photos.split(",")
		@photo_list = Photo.find_all_by_id(photo_ids)
		move_up 30
    repeat(:all) do
		  header
    end  
		move_down 30
		
		# table photo_rows do
		# 	row(0).font_style = :bold
		# 	row(0).background_color = "AAAAAA"
		# 	self.row_colors = ["DDDDDD", "FFFFFF"]
  #   	self.header = true
		# end

    photo_rows

	end

	def header
		logo
    move_down(30)
	end
	
	def logo
		image open("#{Rails.root}/app/assets/images/SNAPSHOT_logo.jpg"), :width => 200	
	end

  def photo_rows
    @photo_list.map do |photo|
      define_grid(:columns => 5, :rows => 1, :gutter => 0)

      grid(0,0).bounding_box do
        photo_image photo
      end
      grid([0,2],[0,5]).bounding_box do
        photo_details photo  
      end
      start_new_page
    end
  end

  def photo_image(photo)
		# text "File Name: #{@photo.photo_file_name}", :size => 14, :style => :bold
		image open("#{photo.photo.url(:large)}"), :width => 200
		# image open("#{@photo.photo.url(:medium).to_s.sub!(/\?.+\Z/, '')}")
	end
  # using custom fonts
  # font("#{Prawn::DATADIR}/fonts/Chalkboard.ttf") do
	# 	text "Written with the Chalkboard TTF font."
	# end
	
  def photo_details photo
 
        
        if photo.audit.store

          data = [[ "Retailer","#{photo.audit.store.retailer.name}"]]
          data += [[ "Retail Sector","#{photo.audit.store.retailer.sector.name}"]]
          data += [[ "Store Name","#{photo.audit.store.name}"]]
          # sector = "#{photo.audit.store.retailer.sector.name}"
          # store =  "#{photo.audit.store.name}"
          
          if photo.audit.store.address.present?
            address = "Address: #{photo.audit.store.address}, "
          end
          if photo.audit.store.address2.present?
            address = address +"#{photo.audit.store.address2}, "
          end
          if photo.audit.store.address3.present?
            address = address + "#{photo.audit.store.address3}, "
          end
          if photo.audit.store.town.present?
            address = address + "#{photo.audit.store.town}, "
          end
          if photo.audit.store.postcode.present?
            address = address + "#{photo.audit.store.postcode}"
          end
          data += [[ "Address", address]]
          unless photo.audit.store.country_id.nil?
            data += [[ "Country", "#{photo.audit.store.country.name}" ]]
          end
          data += [[ "Store Format", "#{photo.audit.store.store_format.name}" ]]
          data += [[ "Environment Type:", "#{photo.audit.store.environment_type.name}" ]]
          if photo.audit.store.channel.present?
            data += [[ "Channel","#{photo.audit.store.channel.name}"]]
          end 
        end
  
      if photo.categories.present?
        data += [[ "Categories","#{photo.categories.map(&:name).join(", ")}"]]
      end
      if photo.brands
          data += [[ "Brands", "#{photo.brands.map(&:name).join(", ")}"]]
      end
      if photo.promotion_calendar_id.present?
        data += [[ "Promotion Calendar", "#{photo.promotion_calendar.name}"]]
      end  
      if photo.promotion_types
          promotion_types = 
          data += [[ "Promotion Types", "#{photo.promotion_types.map(&:name).join(", ")}"]]
      end
      if photo.media_locations
        data += [[ "Promotion Types", "#{photo.media_locations.map(&:name).join(", ")}"]]
      end
      if photo.media_types
        data += [[ "Media Types", "#{photo.media_types.map(&:name).join(", ")}"]]
      end   
      if photo.media_vehicles
        data += [[ "Media Types", "#{photo.media_vehicles.map(&:name).join(", ")}"]]
      end 
      
      table(data, :width => 300, :row_colors => ["FFFFFF", "FFFFCC"])
      
  end
end