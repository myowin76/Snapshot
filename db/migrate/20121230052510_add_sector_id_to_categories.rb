class AddSectorIdToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :sector_id, :integer
  end

end
