class Promotiontype < ActiveRecord::Base
  attr_accessible :photo_id, :promotion_type_id
  
  belongs_to :photo
  belongs_to :promotion_type
end
