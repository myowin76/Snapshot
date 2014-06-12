class AddProjectsToSubscription < ActiveRecord::Migration
  def change
    add_column :subscriptions, :projects, :text
  end
end
