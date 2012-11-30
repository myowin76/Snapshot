class Mediatype < ActiveRecord::Base
  attr_accessible :media_type_id, :photo_id

  belongs_to :photo
  belongs_to :media_type
end
