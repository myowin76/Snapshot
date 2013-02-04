class EnvironmentType < ActiveRecord::Base
  attr_accessible :description, :name
  has_many :audits
  has_many :photos, :through => :audits

  # added after data structure changes
  has_many :stores
end
