json.(@photos) do |json, photo|
	
	json.id photo.id
	json.audit_id photo.audit_id
	
	json.url photo.photo.url(:medium)

	json.brands photo.brands do |json, brand|
		json.id brand.id
		json.name brand.name
	end
	
end