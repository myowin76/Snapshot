class Category < ActiveRecord::Base
  attr_accessible :description, :name, :sector_id

  has_many :categorizations
	has_many :photos, :through => :categorizations
	belongs_to :sector

end
