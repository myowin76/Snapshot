class MediaLocation < ActiveRecord::Base
  attr_accessible :description, :name

  has_many :medialocations
  has_many :photos, :through => :medialocations

  validates :name, :presence => true
  validates :name, :uniqueness => {:message => "Media Location exist."}

end
