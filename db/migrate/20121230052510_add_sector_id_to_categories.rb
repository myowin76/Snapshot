class AddSectorIdToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :sector_id, :integer
  end
  add_index :categories, :sector_id
end
