class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :name
      t.string :address
      t.string :address2
      t.string :postcode
      t.references :store_format
      t.references :retailer
      t.references :country
      t.decimal :longitude, :precision => 15, :scale => 10
      t.decimal :latitude, :precision => 15, :scale => 10
      t.text :description

      t.timestamps
    end
  end
end
