class AddReferenceToAudits < ActiveRecord::Migration
  def change
    add_column :audits, :reference, :string
  end
end
