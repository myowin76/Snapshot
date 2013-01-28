class Brand < ActiveRecord::Base
  attr_accessible :description, :name, :owner, :brand_owner_id

  has_many :brandings
  has_many :photos, :through => :brandings
  belongs_to :brand_owner

 #  def self.tokens(query)
	#   brands = where("name like ?", "#{query}%")
	#   # if brands.empty?
	#   #   [{id: "<<<#{query}>>>", name: "New: \"#{query}\""}]
	#   # end
	# end
end
