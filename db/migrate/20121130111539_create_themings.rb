class CreateThemings < ActiveRecord::Migration
  def change
    create_table :themings do |t|
      t.integer :photo_id
      t.integer :theme_id

      t.timestamps
    end
    add_index :themings, :photo_id
    add_index :themings, :theme_id
  end
end
