class StoreFormat < ActiveRecord::Base
  attr_accessible :description, :name

  has_many :stores
  validates :name, :presence => true
  validates :name, :uniqueness => {:message => "Store Format exist."}
  
end
