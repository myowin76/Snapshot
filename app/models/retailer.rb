class Retailer < ActiveRecord::Base
  attr_accessible :description, :name, :sector_id
  
  belongs_to :sector
  has_many :stores
  has_many :audits, :through => :stores
  # has_many :photos, :through => :audits

  validates :name, :sector_id, :presence => true

  
end
