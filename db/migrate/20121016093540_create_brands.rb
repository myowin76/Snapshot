class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.string :name
      t.string :owner
      t.text :description

      t.timestamps
    end
    Brand.create(:name=>'Coca Cola', :owner=>'Unilever')
  end
end
