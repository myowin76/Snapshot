json.(@photos) do |json, photo|
	
	json.id photo.id
	json.audit_id photo.audit_id
	json.photo_file_name photo.photo_file_name
	json.photo_file_size photo.photo_file_size
	json.photo_content_type photo.photo_content_type
	
	json.url photo.photo.url(:medium)
	# json.headline photo.headline
	# json.promotion_calendar_id photo.promotion_calendar_id

	json.brands photo.brands do |json, brand|
		json.id brand.id
		json.name brand.name
	end

	json.categories photo.categories do |json, cat|
		json.id cat.id
		json.name cat.name
	end

	json.promotion_types photo.promotion_types do |json, pt|
		json.id pt.id
		json.name pt.name
	end
	
end