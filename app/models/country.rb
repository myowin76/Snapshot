class Country < ActiveRecord::Base
  attr_accessible :name, :desc

  has_many :stores
  # has_many :retailers, :through => :stores
  # has_many :locations

  validates :name, :presence => true
  validates :name, :uniqueness => {:message => "Country exist."}
end
