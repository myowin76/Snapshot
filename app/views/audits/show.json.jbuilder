json.audit do |json|
	json.(@audit, :id, :reference, :audit_date, :user_id)
	
	json.edit_url edit_audit_url(@audit) if current_user
	json.store @audit.store, :id, :name
		
end
