class AddAuditDateToAudits < ActiveRecord::Migration
  def change
    add_column :audits, :audit_date, :date, :default => Time.now
  end
end
