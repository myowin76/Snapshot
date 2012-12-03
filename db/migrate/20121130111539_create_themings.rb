class CreateThemings < ActiveRecord::Migration
  def change
    create_table :themings do |t|
      t.integer :photo_id
      t.integer :theme_id

      t.timestamps
    end
  end
end
