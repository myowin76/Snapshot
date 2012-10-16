class CreateStoreFormats < ActiveRecord::Migration
  def change
    create_table :store_formats do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
    StoreFormat.create(:name=>'Extra large (hypermarket)')
	StoreFormat.create(:name=>'Large (large supermarket)')
	StoreFormat.create(:name=>'Medium (High St shop)')
	StoreFormat.create(:name=>'Small (Corner shop, kiosk)')
	StoreFormat.create(:name=>'Online')
  end
end
