class CreateSectors < ActiveRecord::Migration
  def self.up
    create_table :sectors do |t|
      t.string :name
      t.text :desc
      t.timestamps
    end
  end

  def self.down
    drop_table :sectors
  end
end
