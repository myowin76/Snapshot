class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username
  # attr_accessible :title, :body

  #has_many :saved_searches
  has_many :audits
  has_one :subscription
  has_many :save_searches
  belongs_to :user_type

  # check user is admin/subscriber or uploader (user types)
  
private
  # check users' subscriptions
  
end
