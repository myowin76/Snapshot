class Categorization < ActiveRecord::Base
  attr_accessible :category_id, :photo_id
  belongs_to :photo
	belongs_to :category
end
