class Location < ActiveRecord::Base
  belongs_to :country
  has_many :stores
  attr_accessible :description, :name, :country_id
end
