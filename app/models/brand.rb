class Brand < ActiveRecord::Base
  attr_accessible :description, :name, :owner, :brand_owner_id

  has_many :brandings
  has_many :photos, :through => :brandings
  belongs_to :brand_owner


  validates :name, :presence => true
  validates :name, :uniqueness => {:message => "Brand exist."}
 
end
