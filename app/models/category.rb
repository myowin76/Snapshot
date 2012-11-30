class Category < ActiveRecord::Base
  attr_accessible :description, :name

  # has_many :photos
  has_many :categorizations
	has_many :photos, :through => :categorizations

	def self.tokens(query)
	  categories = where("name like ?", "%#{query}%")

	end

	def self.ids_from_tokens(tokens)
	  tokens.gsub!(/<<<(.+?)>>>/) { create!(name: $1).id }
	  tokens.split(',')
	end  
	
end
