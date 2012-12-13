class Channel < ActiveRecord::Base
  attr_accessible :description, :name
  has_many :audits
  has_many :photos, :through => :audits
end
