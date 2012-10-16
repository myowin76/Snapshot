class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
    Category.create(:name=>'Baby care')
	Category.create(:name=>'Beer wines and spirits')
	Category.create(:name=>'Books Stationery Gaming Music')
	Category.create(:name=>'Bread, cakes, biscuits')
	Category.create(:name=>'Breakfast cereals')
	Category.create(:name=>'Clothing and footwear')
	Category.create(:name=>'General produce, dry goods')
	Category.create(:name=>'Confectionery')
	Category.create(:name=>'Tobacco')
	Category.create(:name=>'News, Magazines')
	Category.create(:name=>'Dairy')
	Category.create(:name=>'Fresh produce, deli')
	Category.create(:name=>'DIY, Outdoors')
	Category.create(:name=>'Frozen')
	Category.create(:name=>'Health, vitamins, pharmacy')
	Category.create(:name=>'Homebaking')
	Category.create(:name=>'Homewares')
	Category.create(:name=>'Hot beverages')
	Category.create(:name=>'Household cleaning')
	Category.create(:name=>'Lunchtime, takeaway')
	Category.create(:name=>'Oral care')
	Category.create(:name=>'Personal hygiene')
	Category.create(:name=>'World food')
	Category.create(:name=>'Ready meals')
	Category.create(:name=>'Savoury snacks')
	Category.create(:name=>'Savoury snacks')
	Category.create(:name=>'Soft drinks')
	Category.create(:name=>'Sportswear')
	Category.create(:name=>'Audio visual (TV, video & Music)')
	Category.create(:name=>'Computers & accessories')
	Category.create(:name=>'Cameras & accessories')
	Category.create(:name=>'Household appliances')
	Category.create(:name=>'DVDs')
	Category.create(:name=>'Toys')
	Category.create(:name=>'Automotive')
	Category.create(:name=>'Gift cards')
	Category.create(:name=>'Pet care')
	Category.create(:name=>'Financial service')
	Category.create(:name=>'Value aisle')
	Category.create(:name=>'Health & Beauty')
  end
end
