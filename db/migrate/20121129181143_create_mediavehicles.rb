class CreateMediavehicles < ActiveRecord::Migration
  def change
    create_table :mediavehicles do |t|
      t.integer :photo_id
      t.integer :media_vehicle_id

      t.timestamps
    end
    add_index :mediavehicles, :photo_id
    add_index :mediavehicles, :media_vehicle_id
  end
end
