class	PhotoListPdf < Prawn::Document
	def initialize(photos)
		super(top_margin: 70)
		@photos = photos
		header
		move_down(30)
		table photo_rows

		# photo_image
		# move_down(30)
		# photo_table
		# move_down(10)
		
	end


	def header
		logo
	end
	def logo
		image open("#{Rails.root}/app/assets/images/d3c42e08.snapshot-logo.png"), :width => 200	
	end
	def photo_rows
		
    [["Image", "Date"],['test','test'],['row2', 'row2']]
    # @photos.each do |photo|
    #   [ photo.id, photo.id ]
    # end  
  
    
  end

  # using custom fonts
  # font("#{Prawn::DATADIR}/fonts/Chalkboard.ttf") do
	# 	text "Written with the Chalkboard TTF font."
	# end
	

	# def photo_image
	# 	text "File Name: #{@photo.photo_file_name}", :size => 14, :style => :bold
	# 	image open("#{@photo.photo.url(:medium)}")
	# 	# image open("#{@photo.photo.url(:medium).to_s.sub!(/\?.+\Z/, '')}")
	# end

	# def photo_table
	# 	text "Retailer: #{@photo.audit.retailer.name}", :size => 12
	# 	text "Store: #{@photo.audit.store.name}", :size => 12
	# 	text "Store Format: #{@photo.audit.store.store_format.name}"
	# 	text "Sector: #{@photo.audit.store.retailer.sector.name}"
	# 	text "Environment Type: #{@photo.audit.environment_type.name}"
	# 	text "Country: #{@photo.audit.store.country.name}"

	# 	if @photo.categories
	# 		@photo.categories.each do |cat|
	# 			text "Category: #{cat.name}", :size => 12
	# 		end
	# 	end
	# 	if @photo.brands
	# 		@photo.brands.each do |brand|
	# 			text "Brand: #{brand.name}", :size => 12
	# 		end
	# 	end

	# 	text "Promotion Calendar: #{@photo.promotion_calendar.name unless @photo.promotion_calendar_id.nil? }"
	# 	if @photo.promotion_types
	# 		@photo.promotion_types.each do |pt|
	# 			text "Promotion Type: #{pt.name}"
	# 		end
	# 	end
	# 	if @photo.media_locations
	# 		@photo.media_locations.each do |ml|		
	# 			text "Media Location: #{ml.name }"
	# 		end
	# 	end
	# 	if @photo.media_types
	# 		@photo.media_types.each do |mt|		
	# 			text "Media Type: #{mt.name}"
	# 		end
	# 	end		
	# 	if @photo.media_vehicles
	# 		@photo.media_vehicles.each do |mv|		
	# 			text "Media Vehicle: #{mv.name}"
	# 		end
	# 	end		
		
	# end
end