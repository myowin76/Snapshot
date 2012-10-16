class CreateMediaVehicles < ActiveRecord::Migration
  def change
    create_table :media_vehicles do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
    MediaVehicle.create(:name=>'2D (printed message)')
	MediaVehicle.create(:name=>'Scanning (QR, other)')
	MediaVehicle.create(:name=>'Projected image (hologram)')
	MediaVehicle.create(:name=>'Other (name)')
  end
end
