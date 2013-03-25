class	PhotoPdf < Prawn::Document

	def initialize(photo)
		super()
		@photo = photo
		logo
		move_down(10)
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
		image open("#{@photo.photo.url(:large)}")
		# image open("#{@photo.photo.url(:medium).to_s.sub!(/\?.+\Z/, '')}")

	end

	def photo_details
		
		# start_new_page
		# grid.show_all
		# grid([3,0], [2,1]).bounding_box do
		# end	
			photo_image
			move_down(10)

			text "Retailer: #{@photo.audit.store.retailer.name}", :size => 12
			text "RetailSector: #{@photo.audit.store.retailer.sector.name}"
			text "Store: #{@photo.audit.store.name}", :size => 12
			if @photo.audit.store.address.present?
				text "Address: #{@photo.audit.store.address}, ", :size => 12
			end
			if @photo.audit.store.address2.present?
				text " #{@photo.audit.store.address2}, ", :size => 12
			end
			if @photo.audit.store.address3.present?
				text "#{@photo.audit.store.address3}, ", :size => 12
			end
			if @photo.audit.store.address.present?
				text "#{@photo.audit.store.town}, ", :size => 12
			end
			if @photo.audit.store.address.present?
				text "#{@photo.audit.store.postcode}", :size => 12
			end
			# text "#{@photo.audit.store.address2}, #{@photo.audit.store.address3} #{@photo.audit.store.town}
			# 			#{@photo.audit.store.postcode}", :size => 12
			text "Country: #{@photo.audit.store.country.name}" unless @photo.audit.store.country_id.nil?
			text "Store Format: #{@photo.audit.store.store_format.name}"
			text "Environment Type: #{@photo.audit.store.environment_type.name}"
			if @photo.audit.store.channel.present?
				text "Channel: #{@photo.audit.store.channel.name}"
			end	
			
		if @photo.categories
			@photo.categories.each do |cat|
				text "Category: #{cat.name}", :size => 12
			end
		end
		if @photo.brands
				text "Brands: #{@photo.brands.map(&:name).join(", ")}", :size => 12
		end

		text "Promotion Calendar: #{@photo.promotion_calendar.name unless @photo.promotion_calendar_id.nil? }"
		if @photo.promotion_types
				text "Promotion Types: #{@photo.promotion_types.map(&:name).join(", ")}"
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