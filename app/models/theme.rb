class Theme < ActiveRecord::Base
  attr_accessible :description, :name
  has_many :photos
end
