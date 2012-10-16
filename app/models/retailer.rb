class Retailer < ActiveRecord::Base
  attr_accessible :description, :name, :sector_id
  
  belongs_to :sector
  has_many :stores
end