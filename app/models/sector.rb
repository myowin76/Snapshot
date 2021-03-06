class Sector < ActiveRecord::Base
  attr_accessible :name, :desc
  has_many :retailers
  has_many :stores, :through => :retailers

  # has_many :categories

  validates :name, :presence => true
  validates :name, :uniqueness => {:message => "Sector exist."}

end
