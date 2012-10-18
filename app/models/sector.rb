class Sector < ActiveRecord::Base
  attr_accessible :name, :desc
  has_many :retailers


  def self.search(search)
	  if search
	    find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
	  else
	    find(:all)
	  end
	end
end
