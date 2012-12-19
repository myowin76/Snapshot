class CreateAudits < ActiveRecord::Migration
  def change
    create_table :audits do |t|
      t.references :store
      t.references :environment_type
      t.references :channel
      t.references :retailer
      t.references :user

      t.timestamps
    end
    add_index :audits, :user_id
    add_index :audits, :store_id
    add_index :audits, :environment_type_id
    add_index :audits, :channel_id
  end
end
