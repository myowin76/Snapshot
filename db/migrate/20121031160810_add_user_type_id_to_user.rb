class AddUserTypeIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :user_type_id, :integer, :default => '1'
  end
end
