class Ability
  include CanCan::Ability

  def initialize(user)
  user ||= User.new
  if user.role? :admin
    can :manage, :all
  else

    can :create, User
    can :edit, User do |u|
      u.id == user.id
    end
    can :read, User do |u|
      u.id == user.id
    end
    can :update, User do |u|
      u.id == user.id
    end
    can :destroy, User do |u|
      u.id == user.id
    end

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
      f.propser_id == user.id || f.proposee_id == user.id
    end
    can :edit, Friendship do |f|
      f.propser_id == user.id || f.proposee_id == user.id
    end
    can :update, Friendship do |f|
      f.propser_id == user.id || f.proposee_id == user.id
    end
    can :destroy, Friendship do |f|
      f.propser_id == user.id || f.proposee_id == user.id
    end
  end

  can :create, WifiNetwork
  can :read, WifiNetwork
  can :edit, WifiNetwork
  can :update, WifiNetwork







 end
end
