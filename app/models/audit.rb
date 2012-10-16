class Audit < ActiveRecord::Base
  belongs_to :store
  belongs_to :environment_type
  belongs_to :channel
  belongs_to :retailer
  has_many :photos



  attr_accessible :store_id, :environment_type_id, :channel_id, :retailer_id, :photos_attributes
  accepts_nested_attributes_for :photos, :allow_destroy => true 

end
