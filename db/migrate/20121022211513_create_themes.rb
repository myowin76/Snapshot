class CreateThemes < ActiveRecord::Migration
  def change
    create_table :themes do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
    Theme.create(:name => 'Occasional activity')
    Theme.create(:name => 'Best practice')
    Theme.create(:name => 'Benefit driven')
    Theme.create(:name => 'Feature driven')
    Theme.create(:name => 'Product launch')
    Theme.create(:name => 'Innovation')
    Theme.create(:name => 'Luxury')
    Theme.create(:name => 'Value')
    Theme.create(:name => 'Quality')
  end
end







