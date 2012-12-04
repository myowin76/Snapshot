class	PhotoPdf < Prawn::Document
	def initialize(photo)
		super()
		@photo = photo
		photo_image
		photo_details

		move_down(30)

		move_down(10)

	end
	def photo_image
		text "File Name: #{@photo.photo_file_name}", :size => 14, :style => :bold
		
		image open("#{@photo.photo.url(:medium).to_s.sub!(/\?.+\Z/, '')}")

	end
	def photo_details
		@categories 

		text "Category: #{@photo.categories.first.name}", :size => 12
		text "Brand: #{@photo.brands.first.name}", :size => 12
		text "Store: #{@photo.audit.store.name}", :size => 12
		text "Retailer: #{@photo.audit.retailer.name}", :size => 12

		text "Promotion Calendar: #{@photo.promotion_calendar.name unless @photo.promotion_calendar_id.nil? }"
		text "Promotion Type: #{@photo.promotion_types.first.name if @photo.promotion_types }"
		text "Media Location: #{@photo.media_locations.first.name  if @photo.media_locations }"
		text "Media Type: #{@photo.media_types.first.name if @photo.media_types }"
		text "Sector: #{@photo.audit.store.retailer.sector.name}"
		text "Environment Type: #{@photo.audit.environment_type.name}"
		text "Media Vehicle: #{@photo.media_vehicles.first.name if @photo.media_vehicles }"
		text "Country: #{@photo.audit.store.country.name}"
		text "Store Format: #{@photo.audit.store.store_format.name}"
		
	end
end