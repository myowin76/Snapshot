class	PhotoPdf < Prawn::Document

	def initialize(photo)
		super()
		@photo = photo
		logo
		move_down(30)
		#define_grid(:columns => 2, :rows => 8, :gutter => 10)
		
		move_down(30)
		photo_details

		move_down(10)

	end

	def logo
		image open("#{Rails.root}/app/assets/images/SNAPSHOT_logo.jpg"), :width => 200	
	end
	
	def photo_image
		# text "File Name: #{@photo.photo_file_name}", :size => 14, :style => :bold
		image open("#{@photo.photo.url(:medium)}") #, :width => 200
		# image open("#{@photo.photo.url(:medium).to_s.sub!(/\?.+\Z/, '')}")

	end

	def photo_details
		
		# start_new_page
		# grid.show_all
		# grid([3,0], [2,1]).bounding_box do
		# end	
			text "Store: #{@photo.audit.store.name}", :size => 12
			text "Address: #{@photo.audit.store.address}, #{@photo.audit.store.address2}, #{@photo.audit.store.address3} #{@photo.audit.store.town}
						#{@photo.audit.store.postcode}", :size => 12
			text "#{@photo.audit.store.country.name}" unless @photo.audit.store.country_id.nil?
			text "Store Format: #{@photo.audit.store.store_format.name}"
			text "Environment Type: #{@photo.audit.store.environment_type.name}"
			text "Channel: #{@photo.audit.store.channel.name}"
			
			move_down(10)
			photo_image
			move_down(10)
			
			text "Date:#{@photo.created_at}", :size => 12
			text "Retailer: #{@photo.audit.store.retailer.name}", :size => 12
			text "Sector: #{@photo.audit.store.retailer.sector.name}"
		
		if @photo.categories
			@photo.categories.each do |cat|
				text "Category: #{cat.name}", :size => 12
			end
		end
		if @photo.brands
			@photo.brands.each do |brand|
				text "Brand: #{brand.name}", :size => 12
			end
		end

		text "Promotion Calendar: #{@photo.promotion_calendar.name unless @photo.promotion_calendar_id.nil? }"
		if @photo.promotion_types
			@photo.promotion_types.each do |pt|
				text "Promotion Type: #{pt.name}"
			end
		end
		if @photo.media_locations
			@photo.media_locations.each do |ml|		
				text "Media Location: #{ml.name }"
			end
		end
		if @photo.media_types
			@photo.media_types.each do |mt|		
				text "Media Type: #{mt.name}"
			end
		end		
		if @photo.media_vehicles
			@photo.media_vehicles.each do |mv|		
				text "Media Vehicle: #{mv.name}"
			end
		end		
		
	end
end