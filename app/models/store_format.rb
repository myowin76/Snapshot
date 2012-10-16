class StoreFormat < ActiveRecord::Base
  attr_accessible :description, :name

  has_many :stores
end
