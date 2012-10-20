class CreateRetailers < ActiveRecord::Migration
  def change
    create_table :retailers do |t|
      t.string :name
      t.references :sector
      t.text :description

      t.timestamps
    end
    Retailer.create(:name=>'Automotive', :sector_id=>'3')
		Retailer.create(:name=>'Game', :sector_id=>'3')
		Retailer.create(:name=>'Gamestation', :sector_id=>'5')
		Retailer.create(:name=>'HMV', :sector_id=>'7')
		Retailer.create(:name=>'Rymans', :sector_id=>'2')
		Retailer.create(:name=>'Staples', :sector_id=>'1')
		Retailer.create(:name=>'WH Smith', :sector_id=>'1')
		Retailer.create(:name=>'BP', :sector_id=>'9')
		Retailer.create(:name=>'Budgens', :sector_id=>'6')
		Retailer.create(:name=>'Costcutter', :sector_id=>'1')
		Retailer.create(:name=>'Esso', :sector_id=>'1')
		Retailer.create(:name=>'Nisa', :sector_id=>'3')
		Retailer.create(:name=>'Sainsbury\'s local', :sector_id=>'3')
		Retailer.create(:name=>'Shell', :sector_id=>'3')
		Retailer.create(:name=>'Spar', :sector_id=>'3')
		Retailer.create(:name=>'Tesco Express', :sector_id=>'3')
		Retailer.create(:name=>'Total', :sector_id=>'3')
		Retailer.create(:name=>'Argos', :sector_id=>'3')
		Retailer.create(:name=>'Debenhams', :sector_id=>'3')
		Retailer.create(:name=>'M&S', :sector_id=>'3')
		Retailer.create(:name=>'B&Q', :sector_id=>'3')
		Retailer.create(:name=>'Homebase', :sector_id=>'3')
		Retailer.create(:name=>'IKEA', :sector_id=>'3')
		Retailer.create(:name=>'Comet', :sector_id=>'3')
		Retailer.create(:name=>'Currys', :sector_id=>'3')
		Retailer.create(:name=>'Currys.digital', :sector_id=>'3')
		Retailer.create(:name=>'PC World', :sector_id=>'3')
		Retailer.create(:name=>'3 Store', :sector_id=>'3')
		Retailer.create(:name=>'Carphone', :sector_id=>'3')
		Retailer.create(:name=>'O2', :sector_id=>'3')
		Retailer.create(:name=>'Orange', :sector_id=>'3')
		Retailer.create(:name=>'Phones 4u', :sector_id=>'3')
		Retailer.create(:name=>'T Mobile', :sector_id=>'3')
		Retailer.create(:name=>'Virgin Mobile', :sector_id=>'3')
		Retailer.create(:name=>'Vodafone', :sector_id=>'3')
		Retailer.create(:name=>'Barclays', :sector_id=>'3')
		Retailer.create(:name=>'Halifax', :sector_id=>'3')
		Retailer.create(:name=>'HSBC', :sector_id=>'3')
		Retailer.create(:name=>'Lloyds', :sector_id=>'3')
		Retailer.create(:name=>'NatWest', :sector_id=>'3')
		Retailer.create(:name=>'RBS', :sector_id=>'3')
		Retailer.create(:name=>'Santander', :sector_id=>'3')
		Retailer.create(:name=>'Aldi', :sector_id=>'3')
		Retailer.create(:name=>'Asda', :sector_id=>'3')
		Retailer.create(:name=>'Co op', :sector_id=>'3')
		Retailer.create(:name=>'Farm Foods', :sector_id=>'3')
		Retailer.create(:name=>'Iceland', :sector_id=>'3')
		Retailer.create(:name=>'M&S food', :sector_id=>'3')
		Retailer.create(:name=>'Lidl', :sector_id=>'3')
		Retailer.create(:name=>'Morrisons', :sector_id=>'3')
		Retailer.create(:name=>'Netto', :sector_id=>'3')
		Retailer.create(:name=>'Sainsburys', :sector_id=>'3')
		Retailer.create(:name=>'Tesco', :sector_id=>'3')
		Retailer.create(:name=>'Waitrose', :sector_id=>'3')
		Retailer.create(:name=>'Boots', :sector_id=>'3')
		Retailer.create(:name=>'Superdrug', :sector_id=>'3')
		Retailer.create(:name=>'3 Store', :sector_id=>'3')
		Retailer.create(:name=>'Carphone', :sector_id=>'3')
		Retailer.create(:name=>'O2', :sector_id=>'3')
		Retailer.create(:name=>'Orange', :sector_id=>'3')
		Retailer.create(:name=>'Phones 4u', :sector_id=>'3')
		Retailer.create(:name=>'T Mobile', :sector_id=>'3')
		Retailer.create(:name=>'Virgin Mobile', :sector_id=>'3')
		Retailer.create(:name=>'Vodafone', :sector_id=>'3')
		Retailer.create(:name=>'Burger King', :sector_id=>'3')
		Retailer.create(:name=>'KFC', :sector_id=>'3')
		Retailer.create(:name=>'McDonalds', :sector_id=>'3')
		Retailer.create(:name=>'Pizza Hut', :sector_id=>'3')
		Retailer.create(:name=>'Westfield', :sector_id=>'3')
		Retailer.create(:name=>'Lakeside Thurrock', :sector_id=>'3')
		Retailer.create(:name=>'Bluewater', :sector_id=>'3')

    add_index :retailers, :sector_id	
  end
end
