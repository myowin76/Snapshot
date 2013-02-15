class MediaType < ActiveRecord::Base
  attr_accessible :description, :name

  has_many :mediatypes
  has_many :photos, :through => :mediatypes

  validates :name, :presence => true
  validates :name, :uniqueness => {:message => "Media Type exist."}

end
