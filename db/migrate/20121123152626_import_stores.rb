class ImportStores < ActiveRecord::Migration
  def up
  	File.open(File.join(Rails.root, 'bin', 'stores.csv')) do |file|
      file.each do |line|
        id, name, address, address2, postcode, store_format_id, retailer_id, country_id, longitude, latitude, description = line.chomp.split(',')
				insert "INSERT INTO stores(id, name, address, address2, postcode, store_format_id, retailer_id, country_id, longitude, latitude, description) 
				VALUES (#{id}, #{name}, #{address}, #{address2}, #{postcode}, #{store_format_id}, #{retailer_id}, #{country_id}, #{longitude}, #{latitude}, #{description})"
      end
    end
  end

  def down
  end
end
