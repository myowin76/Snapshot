class CreateBrandOwners < ActiveRecord::Migration
  def change
    create_table :brand_owners do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
