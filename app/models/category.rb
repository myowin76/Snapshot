class Category < ActiveRecord::Base
  attr_accessible :description, :name

  has_many :photos

	def self.tokens(query)
	  categories = where("name like ?", "%#{query}%")

	end

	def self.ids_from_tokens(tokens)
	  tokens.gsub!(/<<<(.+?)>>>/) { create!(name: $1).id }
	  tokens.split(',')
	end  
	
end
