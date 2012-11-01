class Retailer < ActiveRecord::Base
  attr_accessible :description, :name, :sector_id
  
  belongs_to :sector
  has_many :stores
  has_many :countries, :through => :stores


  #named_scope :with_stores, :joins => :stores, 
  #	:select => 'distinct(retailers.id), retailers.*', :having => "count(stores.id) > 0"

end
