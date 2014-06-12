class ProjectPhoto < ActiveRecord::Base
  attr_accessible :photo_id, :project_id

  belongs_to :photo
	belongs_to :project
end
