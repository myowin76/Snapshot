class AddDataCompleteToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :data_complete, :boolean
  end
end
