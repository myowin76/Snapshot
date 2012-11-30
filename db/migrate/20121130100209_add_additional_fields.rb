class AddAdditionalFields < ActiveRecord::Migration
  def up
  	def change
    add_column :photos, :display_for_project, :boolean, :default => false
    add_column :photos, :brand_compliant, :boolean, :default => false
  end
  end

  def down
  end
end
