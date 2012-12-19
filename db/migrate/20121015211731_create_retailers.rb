class CreateRetailers < ActiveRecord::Migration
  def change
    create_table :retailers do |t|
      t.string :name
      t.references :sector
      t.text :description

      t.timestamps
    end
    add_index :retailers, :sector_id	
  end
end
