class CreateMediaTypes < ActiveRecord::Migration
  def change
    create_table :media_types do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
    MediaType.create(:name=>'Wobblers')
		MediaType.create(:name=>'Web page')
		MediaType.create(:name=>'Staff clothing/apparel')
		MediaType.create(:name=>'Signage, Fascia')
		MediaType.create(:name=>'Shelf edge')
		MediaType.create(:name=>'Shelf barker/bus stop')
		MediaType.create(:name=>'Sampling')
		MediaType.create(:name=>'Poster')
		MediaType.create(:name=>'On pack')
		MediaType.create(:name=>'Literature')
		MediaType.create(:name=>'Hanging banner')
		MediaType.create(:name=>'Gondola end')
		MediaType.create(:name=>'General Category, context')
		MediaType.create(:name=>'FSDU')
		MediaType.create(:name=>'Floor media')
		MediaType.create(:name=>'Digital, scanning, screen')
		MediaType.create(:name=>'Cash till')
		MediaType.create(:name=>'Dump/product bin')
		MediaType.create(:name=>'Secondary packaging')
		MediaType.create(:name=>'Parasitic hanger, clip strip')
		MediaType.create(:name=>'Bulk shipper')
		MediaType.create(:name=>'A frame/freestanding poster')
		MediaType.create(:name=>'Pole sleeve')
		MediaType.create(:name=>'Trolley media')

  end
end
