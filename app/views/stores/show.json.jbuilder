json.store do |json|
	json.(@store, :id, :name, :address, :address2, :address3, :town, :postcode)
	json.environment_type @store.environment_type, :id, :name
	json.channel @store.channel, :id, :name
	json.country @store.country, :id, :name
	json.edit_url edit_store_url(@store) if current_user

	json.retailer do |json|
		json.(@store.retailer, :id, :name)
		json.sector @store.retailer.sector, :id, :name
	end	

	json.audits @store.audits do |json, audit|
		json.partial! audit
	end
end
