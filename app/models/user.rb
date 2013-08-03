class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :street_address, :postcode, :biography, :user_image, :role, :remember_me

  has_many :friendships_as_proposer, class_name: "Friendship", foreign_key: :proposer_id
  has_many :friendships_as_proposee, class_name: "Friendship", foreign_key: :proposee_id
  has_many :user_networks

  SHARING_PREFERENCES = ['acquaintance', 'friend', 'close friend']

  def friends
    proposees = self.friendships_as_proposer.map {|friendship| friendship.proposee}
    proposers = self.friendships_as_proposee.map {|friendship| friendship.proposer}
    proposees + proposers
  end

  def friends_networks
    user_networks = self.friends.map{|friend| friend.user_networks}
    user_networks.flatten.map{|network| network.wifi_network}.uniq
  end


  def friends_ids
    self.friends.map do |friend|
      friend.id
    end
  end

  def friends_visible_networks
    proposees = self.friendships_as_proposer.map {|friendship| friendship.proposee}
    proposees_networks = proposees.map{|proposee| proposee.user_networks}.flatten

    proposers = self.friendships_as_proposee.map {|friendship| friendship.proposer}
    proposer_networks = proposers.map{|proposer| proposer.user_networks}.flatten

    networks = proposer_networks + proposees_networks
    visible_networks = networks.select{|network| network.shareable_with(self)}
  end

  def make_friendship(current_user, user, sharing_preferences)
      Friendship.create proposer_id: current_user.id, proposee_id: self.id, proposer_sharing_pref: sharing_preferences, proposee_sharing_pref: nil

  # validates :proposer_sharing_pref, inclusion: { in: User::SHARING_PREFERENCES }
  # validates :proposee_sharing_pref, inclusion: { in: User::SHARING_PREFERENCES }
  end

  def check_friendship(current_user, user)
    if Friendship.where(proposer_id: current_user.id) == Friendship.where(proposee_id: user.id)
      return true
    else
      return false
    end
  end

end
