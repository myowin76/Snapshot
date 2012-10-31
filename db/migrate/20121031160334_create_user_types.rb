class CreateUserTypes < ActiveRecord::Migration
  def change
    create_table :user_types do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
    UserType.create(:name => "Admin")
    UserType.create(:name => "Subscriber")
  end
end
