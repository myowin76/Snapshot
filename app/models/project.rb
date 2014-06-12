class Project < ActiveRecord::Base
  attr_accessible :description, :name

  has_many :project_photos
	has_many :photos, :through => :project_photos

  validates :name, :presence => true
  validates :name, :uniqueness => {:message => "Project exist."}
end
