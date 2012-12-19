class CreateMediaLocations < ActiveRecord::Migration
  def change
    create_table :media_locations do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
