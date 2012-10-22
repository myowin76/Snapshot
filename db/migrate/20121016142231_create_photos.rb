class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.references :brand
      t.references :audit
      t.references :category
      t.references :media_location
      t.references :media_vehicle
      t.references :media_type
      t.references :promotion_type
      t.references :promotion_calendar
      t.references :theme
      t.text :description

      t.timestamps
    end
    add_index :photos, :brand_id
    add_index :photos, :audit_id
    add_index :photos, :category_id
    add_index :photos, :media_location_id
    add_index :photos, :media_vehicle_id
    add_index :photos, :media_type_id
    add_index :photos, :promotion_type_id
    add_index :photos, :promotion_calendar_id
    add_index :photos, :theme_id
  end
end
