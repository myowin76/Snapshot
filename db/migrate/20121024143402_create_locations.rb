class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.references :country
      t.text :description

      t.timestamps
    end
    add_index :locations, :country_id
  end
end
