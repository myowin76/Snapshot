class Theme < ActiveRecord::Base
  attr_accessible :description, :name
  
  has_many :themings
  has_many :photos, :through => :themings
end
