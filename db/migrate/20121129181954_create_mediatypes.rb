class CreateMediatypes < ActiveRecord::Migration
  def change
    create_table :mediatypes do |t|
      t.integer :photo_id
      t.integer :media_type_id

      t.timestamps
    end
  end
end
