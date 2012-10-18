class Brand < ActiveRecord::Base
  attr_accessible :description, :name, :owner

  has_many :photos
end
