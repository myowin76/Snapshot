class AddEnvironmentTypeIdAndChannelIdToStore < ActiveRecord::Migration
  def change
    add_column :stores, :environment_type_id, :integer
    add_column :stores, :channel_id, :integer

    add_index :stores, :environment_type_id
    add_index :stores, :channel_id
  end


end
