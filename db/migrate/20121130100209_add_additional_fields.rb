class AddAdditionalFields < ActiveRecord::Migration
  def up
	    add_column :photos, :display_for_project, :boolean, :default => false
	    add_column :photos, :brand_compliant, :boolean, :default => false
	    add_column :photos, :insight, :string
	    add_column :photos, :role_of_comm, :string
  end

  def down
  	remove_column :photos, :display_for_project, :boolean, :default => false
    remove_column :photos, :brand_compliant, :boolean, :default => false
    remove_column :photos, :insight, :string
    remove_column :photos, :role_of_comm, :string
  end
end
