class CreateSectors < ActiveRecord::Migration
  def self.up
    create_table :sectors do |t|
      t.string :name
      t.text :desc
      t.timestamps
    end
    Sector.create(:name => 'Automotive', :desc => '')
    Sector.create(:name => 'Books, Stationery, Gaming, Music, toys', :desc => '')
    Sector.create(:name => 'Clothing, Footwear, jewellery', :desc => '')
    Sector.create(:name => 'Convenience, CTN, Forecourt', :desc => '')
    Sector.create(:name => 'Department and Multicagtegory', :desc => '')
    Sector.create(:name => 'DIY, Furniture, Homeware', :desc => '')
    Sector.create(:name => 'Electricals, Mobile Telecoms', :desc => '')
    Sector.create(:name => 'Electricals, Mobile Telecoms', :desc => '')
    Sector.create(:name => 'Estate agents', :desc => '')
    Sector.create(:name => 'Financial Services', :desc => '')
    Sector.create(:name => 'Grocery', :desc => '')
    Sector.create(:name => 'Health and Beauty', :desc => '')
    Sector.create(:name => 'Hotel, Restaurant, Bar', :desc => '')
    Sector.create(:name => 'Leisure, cinema, casino, betting shops, parks, culture', :desc => '')
    Sector.create(:name => 'Luxury', :desc => '')
    Sector.create(:name => 'Malls and markets', :desc => '')
    Sector.create(:name => 'Travel, duty free, airport retail', :desc => '')
    Sector.create(:name => 'Other (new)', :desc => '')

  end

  def self.down
    drop_table :sectors
  end
end
