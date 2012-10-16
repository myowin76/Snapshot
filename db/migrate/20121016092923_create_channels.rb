class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
    Channel.create(:name=>'Mobile')
	Channel.create(:name=>'Online')
	Channel.create(:name=>'Pop up')
	Channel.create(:name=>'Shop in shop')
	Channel.create(:name=>'Shop/Environment')

  end
end
