class CreateMediaTypes < ActiveRecord::Migration
  def change
    create_table :media_types do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
