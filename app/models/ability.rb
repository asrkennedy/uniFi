class Ability
  include CanCan::Ability

  def initialize(user)
  user ||= User.new
  if user.role? "admin"
    can :manage, :all
  else

    can :create, User
    can :edit, User do |u|
      u.id == user.id
    end
    can :read, User
    can :update, User do |u|
      u.id == user.id
    end
    can :destroy, User do |u|
      u.id == user.id
    end

    can :new_friend, User
    can :friend_add_relationship, User
    can :friend_confirm_relationship, User
    can :friend_update_relationship, User
    can :confirm_friend, User
    can :defriend, User
    can :deny_friend, User
    can :update_friend, User

    can :create, UserNetwork
    can :read, UserNetwork do |n|
      n.user_id == user.id
    end
    can :edit, UserNetwork do |n|
      n.user_id == user.id
    end
    can :update, UserNetwork do |n|
      n.user_id == user.id
    end
    can :destroy, UserNetwork do |n|
      n.user_id == user.id
    end

    can :create, Friendship
    can :read, Friendship do |f|
      f.proposer_id == user.id || f.proposee_id == user.id
    end
    can :edit, Friendship do |f|
      f.proposer_id == user.id || f.proposee_id == user.id
    end
    can :update, Friendship do |f|
      f.proposer_id == user.id || f.proposee_id == user.id
    end
    can :destroy, Friendship do |f|
      f.proposer_id == user.id || f.proposee_id == user.id
    end

    can :read, WifiNetwork



  end







 end
end
