class SaveSearch < ActiveRecord::Base
  belongs_to :user
  attr_accessible :name, :params, :user_id 

  def self.saved_searches user
		find_all_by_user_id(user.id)  	
  end
end
