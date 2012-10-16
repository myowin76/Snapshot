class CreateAudits < ActiveRecord::Migration
  def change
    create_table :audits do |t|
      t.references :store
      t.references :environment_type
      t.references :channel
      t.references :retailer

      t.timestamps
    end
    add_index :audits, :store_id
    add_index :audits, :environment_type_id
    add_index :audits, :channel_id
    add_index :audits, :retailer_id
  end
end
