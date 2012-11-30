class CreatePromotiontypes < ActiveRecord::Migration
  def change
    create_table :promotiontypes do |t|
      t.integer :photo_id
      t.integer :promotion_type_id

      t.timestamps
    end
  end
end
