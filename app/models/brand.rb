class Brand < ActiveRecord::Base
  attr_accessible :description, :name, :owner, :brand_owner_id

  has_many :photos
  belongs_to :brand_owner
end
