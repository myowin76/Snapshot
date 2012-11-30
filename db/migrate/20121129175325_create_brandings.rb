class CreateBrandings < ActiveRecord::Migration
  def change
    create_table :brandings do |t|
      t.integer :photo_id
      t.integer :brand_id

      t.timestamps
    end
  end
end
