class CreatePromotionCalendars < ActiveRecord::Migration
  def change
    create_table :promotion_calendars do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
    PromotionCalendar.create(:name=>'Back to School', :description=>'')
    PromotionCalendar.create(:name=>'Bank Holiday', :description=>'')
    PromotionCalendar.create(:name=>'Bonfire Night', :description=>'')
    PromotionCalendar.create(:name=>'Chinese New Year', :description=>'')
    PromotionCalendar.create(:name=>'Christmas', :description=>'')
    PromotionCalendar.create(:name=>'Easter', :description=>'')
    PromotionCalendar.create(:name=>'Euro 2012', :description=>'')
    PromotionCalendar.create(:name=>'Fair trade Fortnight', :description=>'')
    PromotionCalendar.create(:name=>'Fathers Day', :description=>'')
    PromotionCalendar.create(:name=>'Halloween', :description=>'')
    PromotionCalendar.create(:name=>'January Sales', :description=>'')
    PromotionCalendar.create(:name=>'Diamond Jubilee', :description=>'')
    PromotionCalendar.create(:name=>'London Olympics 2012', :description=>'')
    PromotionCalendar.create(:name=>'May Bank Holiday', :description=>'')
    PromotionCalendar.create(:name=>'Mothering Sunday', :description=>'')
    PromotionCalendar.create(:name=>'New Year', :description=>'')
    PromotionCalendar.create(:name=>'Pancake Day', :description=>'')
    PromotionCalendar.create(:name=>'Sports Relief', :description=>'')
    PromotionCalendar.create(:name=>'Spring Promotions', :description=>'')
    PromotionCalendar.create(:name=>'St Patricks Day', :description=>'')
    PromotionCalendar.create(:name=>'Summer bank holiday ', :description=>'')
    PromotionCalendar.create(:name=>'Summer Holiday', :description=>'')
    PromotionCalendar.create(:name=>'Thanksgiving', :description=>'')
    PromotionCalendar.create(:name=>'Valentines Day', :description=>'')

  end
end
