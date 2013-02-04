class Audit < ActiveRecord::Base
  belongs_to :store
  belongs_to :environment_type
  belongs_to :channel
  belongs_to :retailer
  belongs_to :user
  has_many :photos

  attr_accessible :store_id, :environment_type_id, :channel_id, :retailer_id, :user_id, :photos_attributes, :reference, :created_at
  accepts_nested_attributes_for :photos, :allow_destroy => true 
  
  validates :reference, :presence => true  
  validates :created_at, :presence => true  

  def show_date
    created_at.strftime("%d/%m/%Y")
  end
end
