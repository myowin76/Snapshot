class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.references :country
      t.text :description

      t.timestamps
    end
    Location.create(:name=> 'Ayelsbury', :country_id => '1')
    add_index :locations, :country_id
  end
end
