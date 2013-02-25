class Audit < ActiveRecord::Base
  belongs_to :store
  belongs_to :environment_type
  belongs_to :channel
  belongs_to :retailer
  belongs_to :user
  has_many :photos

  attr_accessible :store_id, :environment_type_id, :channel_id, :retailer_id, 
        :user_id, :reference, :created_at, :photos_attributes, :audit_date
  accepts_nested_attributes_for :photos, :allow_destroy => true 
  
  # validates :reference, :presence => true  
  validates :audit_date, :presence => true  

end
