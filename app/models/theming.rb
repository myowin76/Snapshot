class Theming < ActiveRecord::Base
  attr_accessible :photo_id, :theme_id
  belongs_to :photo
  belongs_to :theme
end
