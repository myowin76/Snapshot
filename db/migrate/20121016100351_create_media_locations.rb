class CreateMediaLocations < ActiveRecord::Migration
  def change
    create_table :media_locations do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
    MediaLocation.create(:name=>'In category')
	MediaLocation.create(:name=>'Out of category (common parts)')
	MediaLocation.create(:name=>'Out of store (eg carpark)')
	MediaLocation.create(:name=>'Checkout')
	MediaLocation.create(:name=>'Online')
	MediaLocation.create(:name=>'Mobile')
  end
end
