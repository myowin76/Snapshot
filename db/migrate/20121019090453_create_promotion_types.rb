class CreatePromotionTypes < ActiveRecord::Migration
  def change
    create_table :promotion_types do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end