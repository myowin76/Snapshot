class CreateMediavehicles < ActiveRecord::Migration
  def change
    create_table :mediavehicles do |t|
      t.integer :photo_id
      t.integer :media_vehicle_id

      t.timestamps
    end
  end
end
