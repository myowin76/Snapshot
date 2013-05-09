class AddSectorRetailerToSubscriptions < ActiveRecord::Migration
  def change
  	add_column :subscriptions, :sectors, :string
    add_column :subscriptions, :retailers, :string

  end
end
