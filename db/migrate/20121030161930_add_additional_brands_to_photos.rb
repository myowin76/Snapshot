class AddAdditionalBrandsToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :additional_brands, :string
  end
end
