class PromotionCalendar < ActiveRecord::Base
  attr_accessible :description, :name

  has_many :photos

  validates :name, :presence => true
  validates :name, :uniqueness => {:message => "Promotion Calendar exist."}
end
