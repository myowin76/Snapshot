class CreateSaveSearches < ActiveRecord::Migration
  def change
    create_table :save_searches do |t|
      t.string :name
      t.text :params
      t.references :user

      t.timestamps
    end
    add_index :save_searches, :user_id
  end
end
