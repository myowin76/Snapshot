class MediaVehicle < ActiveRecord::Base
  attr_accessible :description, :name

  has_many :mediavehicles
  has_many :photos, :through => :mediavehicles
  validates :name, :presence => true
  validates :name, :uniqueness => {:message => "Media Vehicle exist."}
end
