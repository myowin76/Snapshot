class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :sub_cats
      t.string :sub_country
      t.references :user
      t.timestamps
    end
    
    add_index :subscriptions, :user_id
  end
end
