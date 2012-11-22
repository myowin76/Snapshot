class AddBrandOwnerIdToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :brand_owner_id, :integer
  end
end
