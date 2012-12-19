class CreateStoreFormats < ActiveRecord::Migration
  def change
    create_table :store_formats do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
