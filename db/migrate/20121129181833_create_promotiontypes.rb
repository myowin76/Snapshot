class CreatePromotiontypes < ActiveRecord::Migration
  def change
    create_table :promotiontypes do |t|
      t.integer :photo_id
      t.integer :promotion_type_id

      t.timestamps
    end
    add_index :promotiontypes, :photo_id
    add_index :promotiontypes, :promotion_type_id
  end
end
