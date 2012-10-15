class CreateCountries < ActiveRecord::Migration
  def self.up
    create_table :countries do |t|
      t.string :name
      t.text :desc
      t.timestamps
    end
    Country.create(:name => 'England')
    Country.create(:name => 'France')
    Country.create(:name => 'Germany')
    Country.create(:name => 'Italy')
    Country.create(:name => 'Poland')
    Country.create(:name => 'Scotland')
    Country.create(:name => 'Spain')
    Country.create(:name => 'Wales')
  end

  def self.down
    drop_table :countries
  end
end
