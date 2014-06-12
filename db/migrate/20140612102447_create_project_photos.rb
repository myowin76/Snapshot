class CreateProjectPhotos < ActiveRecord::Migration
  def change
    create_table :project_photos do |t|
      t.integer :photo_id
      t.integer :project_id

      t.timestamps
    end
    add_index :project_photos, :photo_id
    add_index :project_photos, :project_id
  end
end
