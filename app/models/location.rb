class Location < ActiveRecord::Base
  belongs_to :country
  attr_accessible :description, :name
end
