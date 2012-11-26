class CreateBrandOwners < ActiveRecord::Migration
  def change
    create_table :brand_owners do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
      BrandOwner.create(:name=>'Aldi Stores')
  end
end
