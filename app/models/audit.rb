class Audit < ActiveRecord::Base
  belongs_to :store
  belongs_to :environment_type
  belongs_to :channel
  belongs_to :retailer
  belongs_to :user
  has_many :photos

  #before_save :get_current_user_id

  attr_accessible :store_id, :environment_type_id, :channel_id, :retailer_id, :user_id, :photos_attributes
  accepts_nested_attributes_for :photos, :allow_destroy => true 
  validates :retailer_id, :presence => true

  scope :all_in_the_country, lambda { |country|
      joins(:store).where('store.country_id IN (?)',
         country) }

  #def get_current_user_id
  #	self.user_id = current_user.id
  	
  #end
end
