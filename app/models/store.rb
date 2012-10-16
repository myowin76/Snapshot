class Store < ActiveRecord::Base
  attr_accessible :address, :address2, :description, :latitude, :longitude, :name, :postcode, :retailer_id, :store_format_id

  belongs_to :store_format
  belongs_to :retailer
end
