class CreateMedialocations < ActiveRecord::Migration
  def change
    create_table :medialocations do |t|
      t.integer :photo_id
      t.integer :media_location_id

      t.timestamps
    end
  end
end
