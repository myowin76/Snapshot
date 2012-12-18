class RemoveThemeIdFromPhotos < ActiveRecord::Migration
  def change
    remove_column :photos, :theme_id
  end
end
