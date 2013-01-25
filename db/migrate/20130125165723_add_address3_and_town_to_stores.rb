class AddAddress3AndTownToStores < ActiveRecord::Migration
  def change
    add_column :stores, :address3, :string
    add_column :stores, :town, :string
  end
end
