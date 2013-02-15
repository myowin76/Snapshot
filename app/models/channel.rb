class Channel < ActiveRecord::Base
  attr_accessible :description, :name
  has_many :audits
  has_many :photos, :through => :audits

  #added after datastructure changes
  has_many :stores
  validates :name, :presence => true
  validates :name, :uniqueness => {:message => "Channel exist."}
end
