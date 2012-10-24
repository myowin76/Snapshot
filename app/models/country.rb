class Country < ActiveRecord::Base
  attr_accessible :name, :desc

  has_many :stores
end
