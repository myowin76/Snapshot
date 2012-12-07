class DataStructureChanges < ActiveRecord::Migration
  def up

  	# execute(%{
   #    INSERT INTO brandings (photo_id, brand_id) 
			# 	SELECT id, brand_id FROM photos
	  # })
	  # execute(%{
   #    INSERT INTO categorizations (photo_id, category_id) 
			# 	SELECT id, category_id FROM photos
	  # })
	  # execute(%{
   #    INSERT INTO medialocations (photo_id, media_location_id) 
			# 	SELECT id, media_location_id FROM photos
	  # })
	  # execute(%{
   #    INSERT INTO mediavehicles (photo_id, media_vehicle_id) 
			# 	SELECT id, media_vehicle_id FROM photos
	  # })
	  # execute(%{
   #    INSERT INTO mediatypes (photo_id, media_type_id) 
			# 	SELECT id, media_type_id FROM photos
	  # })
	  # execute(%{
   #    INSERT INTO promotiontypes (photo_id, promotion_type_id) 
			# 	SELECT id, promotion_type_id FROM photos
	  # })
	  remove_column :photos, :brand_id
	  remove_column :photos, :category_id
	  remove_column :photos, :media_location_id
	  remove_column :photos, :media_vehicle_id
	  remove_column :photos, :media_type_id
	  remove_column :photos, :promotion_type_id
	  
  end

  def down
  	add_column :photos, :brand_id, :integer
  	add_column :photos, :category_id, :integer
  	add_column :photos, :media_location_id, :integer
  	add_column :photos, :media_vehicle_id, :integer
  	add_column :photos, :media_type_id, :integer
  	add_column :photos, :promotion_type_id, :integer

  	# execute(%{
   #    INSERT INTO photos (id, brand_id) 
			# 	SELECT Photoid, brand_id FROM brandings
	  # })
	  # execute(%{
   #    INSERT INTO photos (photo_id, category_id) 
			# 	SELECT id, category_id FROM categorizations
	  # })
	  # execute(%{
   #    INSERT INTO photos (photo_id, media_location_id) 
			# 	SELECT id, media_location_id FROM medialocations
	  # })
	  # execute(%{
   #    INSERT INTO photos (photo_id, media_vehicle_id) 
			# 	SELECT id, media_vehicle_id FROM mediavehicles
	  # })
	  # execute(%{
   #    INSERT INTO photos (photo_id, media_type_id) 
			# 	SELECT id, media_type_id FROM mediatypes
	  # })
	  # execute(%{
   #    INSERT INTO photos (photo_id, promotion_type_id) 
			# 	SELECT id, promotion_type_id FROM promotiontypes
	  # })
  end
end
