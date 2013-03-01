class UsersRoles < ActiveRecord::Migration
  def change
    create_table :roles_users, :id => false do |t|
      t.references :role, :user
      t.timestamps
    end
    add_index :roles_users, :role_id
    add_index :roles_users, :user_id
  end
end
