json.sectors (@sectors) do |json, sector|
	
	json.id sector.id
	json.name sector.name
	#json.retailers sector.retailers, :id, :name
	
end

json.countries (@countries) do |json, country|
	
	json.id country.id
	json.name country.name
	
end

json.categories (@categories) do |json, category|
	
	json.id category.id
	json.name category.name
	
end

json.retailers (@retailers) do |json, retailer|
	
	json.id retailer.id
	json.name retailer.name
	json.sector_id retailer.sector_id
	
end

json.store_formats (@store_formats) do |json, store_format|
	
	json.id store_format.id
	json.name store_format.name
	
end

json.env_types (@env_types) do |json, env_type|
	
	json.id env_type.id
	json.name env_type.name
	
end

json.channels (@channels) do |json, channel|
	
	json.id channel.id
	json.name channel.name
	
end

json.brand_owners (@brand_owners) do |json, brand_owner|
	
	json.id brand_owner.id
	json.name brand_owner.name
	
end

json.brands (@brands) do |json, brand|
	
	json.id brand.id
	json.name brand.name
	json.brand_owner_id brand.brand_owner_id
	
end

json.themes (@themes) do |json, theme|
	
	json.id theme.id
	json.name theme.name
	
end

json.promo_types (@promo_types) do |json, promo_type|
	
	json.id promo_type.id
	json.name promo_type.name
	
end

json.promo_calendars (@promo_calendars) do |json, promo_calendar|
	
	json.id promo_calendar.id
	json.name promo_calendar.name
	
end

json.media_types (@media_types) do |json, media_type|
	
	json.id media_type.id
	json.name media_type.name
	
end

json.media_vehicles (@media_vehicles) do |json, media_vehicle|
	
	json.id media_vehicle.id
	json.name media_vehicle.name
	
end

json.media_locations (@media_locations) do |json, media_location|
	
	json.id media_location.id
	json.name media_location.name
	
end
