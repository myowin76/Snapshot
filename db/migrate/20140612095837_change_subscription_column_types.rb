class ChangeSubscriptionColumnTypes < ActiveRecord::Migration
  def change
    change_column :subscriptions, :sectors, :text
    change_column :subscriptions, :retailers, :text
    change_column :subscriptions, :sub_cats, :text
    change_column :subscriptions, :sub_country, :text
  end
end
