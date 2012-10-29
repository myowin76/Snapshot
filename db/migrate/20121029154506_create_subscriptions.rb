class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :sub_cats
      t.string :sub_country
      t.references :user
      t.timestamps
    end
    Subscription.create(:user_id => '1', :sub_country => '1,2', :sub_cats=>'2,3,4,5,16')
    Subscription.create(:user_id => '2', :sub_country => '', :sub_cats=>'2,3,4,5,16')
    add_index :subscriptions, :user_id
  end
end
