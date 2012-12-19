class CreatePromotionCalendars < ActiveRecord::Migration
  def change
    create_table :promotion_calendars do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
