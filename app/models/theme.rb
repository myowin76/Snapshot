class Theme < ActiveRecord::Base
  attr_accessible :description, :name
  
  has_many :themings
  has_many :photos, :through => :themings
  validates :name, :presence => true
  validates :name, :uniqueness => {:message => "Theme exist."}
end
