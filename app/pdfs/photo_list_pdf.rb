class	PhotoListPdf < Prawn::Document
	def initialize(photos)
		
		super(:page_layout => :landscape, :page_size => "A4", :margin => [60,40])
		font "Helvetica", :size => 8
		
		photo_ids = photos.split(",")
		@photo_list = Photo.find_all_by_id(photo_ids)
		move_up(30)
		header
		move_down(30)
		
		table photo_rows do
			row(0).font_style = :bold
			row(0).background_color = "AAAAAA"
			self.row_colors = ["DDDDDD", "FFFFFF"]
    	self.header = true
		end

		# photo_image
		# move_down(30)
		# photo_table
		# move_down(10)
		
	end

	def header
		logo
	end
	
	def logo
		image open("#{Rails.root}/app/assets/images/SNAPSHOT_logo.jpg"), :width => 200	
	end

	def photo_rows
		
    # [["Image", "Date"],['test','test'],['row2', 'row2']] +
    [["File Name", "Categories", "Brands", "Retailer", "Store", "Media Locations",
    	 "Media Vehicles", "Media Types", "Promotion Calendar", "Promotion Types", "Themes"]] + 
    @photo_list.map do |photo|

    	if photo.audit.store.country_id.nil?
    		country_name = "None"
    	else	
    		country_name = photo.audit.store.country.name
    	end	
    	if photo.media_locations.nil?
    		media_locations = "None"
    	else	
    		media_locations = photo.media_locations.map(&:name).join(",")
    	end
    	if photo.media_vehicles.nil?
    		media_vehicles = "None"
    	else	
    		media_vehicles = photo.media_vehicles.map(&:name).join(", ")
    	end
    	if photo.media_types.nil?
    		media_types = "None"
    	else	
    		media_types = photo.media_types.map(&:name).join(", ")
    	end
    	if photo.promotion_calendar.nil?
    		promotion_calendar = "None"
    	else	
    		promotion_calendar = photo.promotion_calendar.name
    	end	
    	if photo.promotion_types.nil?
    		promotion_types= "None"
    	else	
    		promotion_types = photo.promotion_types.map(&:name).join(", ")
    	end		
    	if photo.themes.nil?
    		themes = "None"
    	else	
    		themes = photo.themes.map(&:name).join(", ")
    	end
    	if photo.categories.nil?
    		categories = "None"
    	else	
    		categories = photo.categories.map(&:name).join(", ")
    	end
    	if photo.brands.nil?
    		brands = "None"
    	else	
    		brands = photo.brands.map(&:name).join(", ")
    	end

      [ 
      	# {:image => photo.photo.url(:medium)},
      	photo.photo_file_name,
      	categories,
      	brands,
      	photo.audit.store.retailer.name,
      	photo.audit.store.name,
      	media_locations,
      	media_vehicles,
      	media_types,
      	promotion_calendar,
      	promotion_types,
      	themes
      	# photo.photo.url(:small)
      	# photo_image(photo)
      ]
    end  
    
  end

  def photo_image(photo)
		# text "File Name: #{@photo.photo_file_name}", :size => 14, :style => :bold
		image open("#{photo.photo.url(:small)}")
		# image open("#{@photo.photo.url(:medium).to_s.sub!(/\?.+\Z/, '')}")
	end
  # using custom fonts
  # font("#{Prawn::DATADIR}/fonts/Chalkboard.ttf") do
	# 	text "Written with the Chalkboard TTF font."
	# end
	

	
end