class CreateMediatypes < ActiveRecord::Migration
  def change
    create_table :mediatypes do |t|
      t.integer :photo_id
      t.integer :media_type_id

      t.timestamps
    end
    add_index :mediatypes, :photo_id
    add_index :mediatypes, :media_type_id
  end
end
