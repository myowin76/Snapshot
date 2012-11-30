class Mediavehicle < ActiveRecord::Base
  attr_accessible :media_vehicle_id, :photo_id
  belongs_to :photo
  belongs_to :media_vehicle
end
