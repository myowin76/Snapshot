class	PhotoListPdf < Prawn::Document
	def initialize(photos)
		
		# super(:page_layout => :landscape, :page_size => "A4", :margin => [60,40])
    super(:page_size => "A4", :margin => [60,40])
		font "Helvetica", :size => 10
		
		photo_ids = photos.split(",")
		@photo_list = Photo.find_all_by_id(photo_ids)
		move_up(30)
		header
		move_down(30)
		
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
	end
	
	def logo
		image open("#{Rails.root}/app/assets/images/SNAPSHOT_logo.jpg"), :width => 200	
	end

  def photo_rows

    @photo_list.map do |photo|
      photo_details photo  
    end  
  end

  def photo_image(photo)
		# text "File Name: #{@photo.photo_file_name}", :size => 14, :style => :bold
		image open("#{photo.photo.url(:large)}"), :width => 400
		# image open("#{@photo.photo.url(:medium).to_s.sub!(/\?.+\Z/, '')}")
	end
  # using custom fonts
  # font("#{Prawn::DATADIR}/fonts/Chalkboard.ttf") do
	# 	text "Written with the Chalkboard TTF font."
	# end
	
  def photo_details photo
        move_down(10)
        photo_image photo
        move_down(10)  
        
        if photo.audit.store

          text "Retailer: #{photo.audit.store.retailer.name}"
          text "Sector: #{photo.audit.store.retailer.sector.name}"
          text "Store: #{photo.audit.store.name}"
          if photo.audit.store.address.present?
            text "Address: #{photo.audit.store.address}, "
          end
          if photo.audit.store.address2.present?
            text " #{photo.audit.store.address2}, "
          end
          if photo.audit.store.address3.present?
            text "#{photo.audit.store.address3}, "
          end
          if photo.audit.store.town.present?
            text "#{photo.audit.store.town}, "
          end
          if photo.audit.store.postcode.present?
            text "#{photo.audit.store.postcode}"
          end
          
          text "Country: #{photo.audit.store.country.name}" unless photo.audit.store.country_id.nil?
          text "Store Format: #{photo.audit.store.store_format.name}"
          text "Environment Type: #{photo.audit.store.environment_type.name}"
          if photo.audit.store.channel.present?
            text "Channel: #{photo.audit.store.channel.name}"
          end 
        end
  
      if photo.categories
        text "Categories: #{photo.categories.map(&:name).join(", ")}"
      end
      if photo.brands
          text "Brands: #{photo.brands.map(&:name).join(", ")}"
      end

      text "Promotion Calendar: #{photo.promotion_calendar.name unless photo.promotion_calendar_id.nil? }"
      if photo.promotion_types
          text "Promotion Types: #{photo.promotion_types.map(&:name).join(", ")}"
      end
      if photo.media_locations
        text "Media Location: #{photo.media_locations.map(&:name).join(", ")}"
      end
      if photo.media_types
        text "Media Types: #{photo.media_types.map(&:name).join(", ")}"
      end   
      if photo.media_vehicles
        text "Media Vehicles: #{photo.media_vehicles.map(&:name).join(", ")}"
      end  
  end
end