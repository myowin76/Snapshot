class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :token_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :role_ids
  # attr_accessible :title, :body

  has_many :audits
  has_one :subscription
  after_create :create_subscription
  # after_update :create_subscription

  has_many :save_searches
  belongs_to :user_type
  has_and_belongs_to_many :roles

  def role?(role)
      return !!self.roles.find_by_name(role.to_s)
  end  
  
end
