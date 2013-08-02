class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :street_address, :postcode, :biography, :user_image, :role

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



  def proposees_visible_networks
   proposees_array = self.friendships_as_proposer.map {|friendship| [friendship.proposee, friendship.proposee_sharing_pref]}
   array_of_networks_and_friendship_sharing_prefs = proposees_array.map {|item|  [item[0].user_networks, item[1]] }






  end



  def visible_networks
    # stuff
  end





end
