class Branding < ActiveRecord::Base
  attr_accessible :brand_id, :photo_id
  belongs_to :photo
	belongs_to :brand
end
