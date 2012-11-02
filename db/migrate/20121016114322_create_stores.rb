class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :name
      t.string :address
      t.string :address2
      t.string :postcode
      t.references :store_format
      t.references :retailer
      t.references :country
      t.decimal :longitude, :precision => 15, :scale => 10
      t.decimal :latitude, :precision => 15, :scale => 10
      t.text :description

      t.timestamps
    end
    Store.create(:name => 'Asda Watford', :address => 'Colne Way Watford North', :address2 =>'Hertfordshire', :postcode => 'WD24 7RT', :store_format_id => '2', :retailer_id => '3', :country_id => '1', :longitude => '-0.3899365E0', :latitude => '0.516794792E2', :description => '')
    Store.create(:name => 'Tesco Watford', :address => '239-241 LOWER HIGH STREET', :address2 =>'Hertfordshire', :postcode => 'WD17 2BD', :store_format_id => '3', :retailer_id => '4', :country_id => '1', :longitude => '-0.3876639E0', :latitude => '0.516514199E2', :description => '')
    Store.create(:name => 'Tesco Greenford', :address => 'OLD HOOVER BUILDING', :address2 =>'WESTERN AVENUE, GREENFORD,', :postcode => 'UB6 8DW', :store_format_id => '3', :retailer_id => '4', :country_id => '1', :longitude => '-0.3876639E0', :latitude => '0.516514199E2', :description => '')

  end
end
