class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:

      # user ||= User.new # guest user (not logged in)
      # if user.role? "admin"
      #   can :manage, :all
      # else
      #   can :read, :all
      #   can [:create, :read], :UserNetwork, :user_sharing_pref => "public"
      #   can [:update, :destroy], :UserNetwork, :user_id => user.id
      #   can [:create, :read], :WifiNetwork
      #   can [:update, :destroy], :WifiNetwork, :user_network => { :user_id => user.id }
      #   can :crud, :WifiNetwork, :password_required => false
      #   can :crud, :Friendship, :proposee_id => user.id, :proposer_id => user.id
      #   can :update, :User, :user_id => user.id
      # end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
