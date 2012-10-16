class CreateEnvironmentTypes < ActiveRecord::Migration
  def change
    create_table :environment_types do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
    EnvironmentType.create(:name=>'Retail park')
	EnvironmentType.create(:name=>'Shopping Street')
	EnvironmentType.create(:name=>'Pedestrianised area')
	EnvironmentType.create(:name=>'Online')
  end
end
