class BrandOwner < ActiveRecord::Base
  attr_accessible :description, :name

  has_many :brands  
  validates :name, :presence => true
  validates :name, :uniqueness => {:message => "Brand Owner exist"}
end
