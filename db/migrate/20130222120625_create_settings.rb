class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
    	t.string :db_update_store
    	t.string :db_update_sector
    	t.string :db_update_retailer
    	t.string :db_update_category
    	t.string :db_update_brand

      t.timestamps
    end
  end
end
