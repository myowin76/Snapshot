class Medialocation < ActiveRecord::Base
  attr_accessible :media_location_id, :photo_id
  belongs_to :photo
  belongs_to :media_location
end
