class AddPerspectiveToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :perspective, :string
  end
end
