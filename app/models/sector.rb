class Sector < ActiveRecord::Base
  attr_accessible :name, :desc
  has_many :retailers
end
