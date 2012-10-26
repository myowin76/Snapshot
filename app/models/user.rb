class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  has_many :searches
  has_many :audits

  # check user is admin/subscriber or uploader (user types)
  
private
  # check users' subscriptions
  def self.subscribed_countries(id)
    # return User.subscription.countries array
    # return false if Self.sub_countries.nil?
    true
  end

  def self.subscribed_categories
    # return User.subscription.categories array
    false
  end

  def self.is_all_subscriber?
    # check user subscription type is all 
    # return true
  end

  def self.is_brand_owner?
    # check user type is brand owner
    # return true
  end
  
end
