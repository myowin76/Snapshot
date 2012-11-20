class AddHeadlineToPhoto < ActiveRecord::Migration
  def change
    add_column :photos, :headline, :string
  end
end
