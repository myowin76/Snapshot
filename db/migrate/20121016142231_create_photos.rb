class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      
      t.references :audit
      t.references :promotion_calendar
      t.text :description

      t.timestamps
    end
    
    add_index :photos, :audit_id
    add_index :photos, :promotion_calendar_id
    
  end
end
