module StoresHelper
	def store_retailer_name
		store.retailer.name		
	end
	def store_sector_name
		store.retailer.sector.name		
	end
end
