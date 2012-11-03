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
		
		text "Category: #{@photo.category.name}", :size => 12
		text "Brand: #{@photo.brand.name}", :size => 12
		text "Store: #{@photo.audit.store.name}", :size => 12
		text "Retailer: #{@photo.audit.retailer.name}", :size => 12

		text "Promotion Calendar: #{@photo.promotion_calendar.name}"
		text "Promotion Type: #{@photo.promotion_type.name}"
		text "Media Location: #{@photo.media_location.name}"
		text "Media Type: #{@photo.media_type.name}"
		text "Sector: #{@photo.audit.store.retailer.sector.name}"
		text "Environment Type: #{@photo.audit.environment_type.name}"
		text "Media Vehicle: #{@photo.media_vehicle.name}"
		text "Country: #{@photo.audit.store.country.name}"
		text "Store Format: #{@photo.audit.store.store_format.name}"
		
	end
end