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
    Store.create(:name => 'Aldi Ayelsbury', :address => '143 Cambridge Close', :address2 =>'Aylesbury', :postcode => 'HP20 1DF', :store_format_id => '2', :retailer_id => '43', :country_id => '1', :longitude => '-0.8077956000', :latitude => '51.8197610000', :description => '')
    Store.create(:name => 'Asda Battersea Clapham', :address => '204 Lavender Hill', :address2 =>'Battersea', :postcode => 'SW11 1JG', :store_format_id => '1', :retailer_id => '44', :country_id => '1', :longitude => '-0.1649623000', :latitude => '51.4653710000', :description => '')
    Store.create(:name => 'Budgens Southfields', :address => '5 Replingham Road, Southfields', :address2 =>'London', :postcode => 'SW18 5LT', :store_format_id => '4', :retailer_id => '9', :country_id => '1', :longitude => '-0.2058516000', :latitude => '51.4448803000', :description => '')
    Store.create(:name => 'Debenhams Edinburgh', :address => '109 Princes Street', :address2 =>'Edinburgh', :postcode => 'EH2 3AA ', :store_format_id => '4', :retailer_id => '9', :country_id => '1', :longitude => '-0.2058516000', :latitude => '51.4448803000', :description => '')        
    
  end
end
