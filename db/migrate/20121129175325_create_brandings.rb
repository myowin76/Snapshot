class CreateBrandings < ActiveRecord::Migration
  def change
    create_table :brandings do |t|
      t.integer :photo_id
      t.integer :brand_id

      t.timestamps
    end
    add_index :brandings, :photo_id
    add_index :brandings, :brand_id
  end
end
