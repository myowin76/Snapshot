class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
      user ||= User.new # guest user (not logged in)
      
      # Super Admin Role
      if user.role? :super_admin
        can :manage, :all
      
      # Admin Role
      elsif user.role? :admin
        # can :read, [Photo, Store]
        # cannot :manage, :users
        can :manage, :all
        
      
      # Uploader
      elsif user.role? :uploader
        can :manage, Store do |store|

        end
        can :manage, [Photo, Audit, Store]


      elsif user.role? :deny_download
          
      # Developer Role
      elsif user.role? :developer
        # can :manage, :all  

      # Other Roles  
      else

        can :read, [Photo]
        
        can :read, Store do |store|
          # photo.show

        end

        # cannot :show, Photo
        # can [ :index, :users_list ], :pages
        cannot [ :show, :edit ], :photos
      end
    
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
