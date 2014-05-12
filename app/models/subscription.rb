class Subscription < ActiveRecord::Base
  attr_accessible :sub_cats, :sub_country, :user_id
  
  belongs_to :user

  # serialize :sub_cats


  def self.countries_by(current_user)
    # return User.subscription.countries array
    # return false if Self.sub_countries.nil?
    Country.find(current_user.sub_country.split(","))
    
  end
  def self.categories_by(current_user)
    # return User.subscription.countries array
    # return false if Self.sub_countries.nil?
    Category.find(current_user.sub_cats.split(","))
    
  end

end
