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
  has_and_belongs_to_many :roles

  # check user is admin/subscriber or uploader (user types)
  def role?(role)
      return !!self.roles.find_by_name(role.to_s)
  end  
private
  # check users' subscriptions
  
end
