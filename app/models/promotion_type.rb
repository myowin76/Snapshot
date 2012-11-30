class PromotionType < ActiveRecord::Base
  attr_accessible :description, :name

  has_many :promotiontypes
  has_many :photos, :through => :promotiontypes
end
