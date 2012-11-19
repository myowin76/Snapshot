class AddLocationIdToStore < ActiveRecord::Migration
  def change
    add_column :stores, :location_id, :integer
  end
end
