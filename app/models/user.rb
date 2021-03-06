class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable

  mount_uploader :user_image, UserImageUploader

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :street_address, :postcode, :biography, :user_image, :user_image_cache, :remove_user_image, :remember_me

  validates :first_name, presence: true
  validates :last_name, presence: true
  # validates_presence_of :user_image
  # validates_integrity_of :user_image
  # validates_processing_of :user_image

  has_many :friendships_as_proposer, class_name: "Friendship", foreign_key: :proposer_id
  has_many :friendships_as_proposee, class_name: "Friendship", foreign_key: :proposee_id
  has_many :user_networks
  before_destroy :delete_friendships_and_networks_before_destroying_user

  SHARING_PREFERENCES = ['public', 'acquaintance', 'friend', 'close friend', 'private']

    def role?(role)
     self.role == role
   end

  def full_name
    "#{first_name} #{last_name}"
  end

  def friends
    proposees = self.friendships_as_proposer.map {|friendship| friendship.proposee}
    proposers = self.friendships_as_proposee.map {|friendship| friendship.proposer}
    proposees + proposers
  end

  def confirmed_friendships
    proposees = self.friendships_as_proposer.where(confirmed: true)
    proposers = self.friendships_as_proposee.where(confirmed: true)
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

  def friendships
    self.friendships_as_proposer + self.friendships_as_proposee
  end

  def friends_visible_networks
    proposees = self.friendships_as_proposer.map {|friendship| friendship.proposee}
    proposees_networks = proposees.map{|proposee| proposee.user_networks}.flatten

    proposers = self.friendships_as_proposee.map {|friendship| friendship.proposer}
    proposer_networks = proposers.map{|proposer| proposer.user_networks}.flatten

    networks = proposer_networks + proposees_networks
    visible_networks = networks.select{|network| network.shareable_with(self)}
    visible_networks.flatten.map{|network| network.wifi_network}.uniq
  end

  def make_friendship(current_user, sharing_preferences)
      Friendship.create proposer_id: current_user.id, proposee_id: self.id, proposer_sharing_pref: sharing_preferences, proposee_sharing_pref: nil

  # validates :proposer_sharing_pref, inclusion: { in: User::SHARING_PREFERENCES }
  # validates :proposee_sharing_pref, inclusion: { in: User::SHARING_PREFERENCES }
  end

  def confirm_friendship(current_user, user, sharing_preferences)
    proposee_friendships = Friendship.where(proposee_id: current_user)
    friend_requests = proposee_friendships.where(confirmed: nil)
    f = friend_requests.where(proposer_id: user)
    f.each do |friend|
      friend.proposee_sharing_pref = sharing_preferences
      friend.confirmed = true
      friend.save
    end
  end

  def update_friendship(current_user, sharing_preferences)
    friendship1 = Friendship.where(proposee_id: current_user.id, proposer_id: self.id)
    friendship2 = Friendship.where(proposer_id: current_user.id, proposee_id: self.id)
    f = friendship1 + friendship2
    f = f.first
    if f.proposer == current_user
      # if f.proposee_id != nil
        f.proposer_sharing_pref = sharing_preferences
        f.save
      # end
    else
      f.proposee_sharing_pref = sharing_preferences
      f.save
    end
  end

  def deny_friendship(current_user, user)
    proposee_friendships = Friendship.where(proposee_id: current_user)
    f = proposee_friendships.where(proposer_id: user)
    f.first.destroy
  end

  def defriend(current_user, user)
    proposee_friendships = Friendship.where(proposee_id: current_user.id)
    proposee_friendships << Friendship.where(proposer_id: current_user.id)

    proposee_friendships.flatten.map do |friendship|
     if friendship.proposer_id == user.id || friendship.proposee_id == user.id
     friendship.destroy
    end
  end
  end

  def check_friendship(current_user, user)
    if Friendship.where(proposer_id: current_user.id) == Friendship.where(proposee_id: user.id)
      return true
    else
      return false
    end
  end


# def update_attributes(current_user, params[:sharing_preferences])

# end

  def find_unconfirmed_friendships
    proposee_friendships = Friendship.where(proposee_id: self.id)
    friend_requests = proposee_friendships.where(confirmed: nil)
      friend_requests.map do |friend_request|
        friend_request.proposer
    end
  # returns an array of proposers (users) of friend requests
  end


  def get_relationship(current_user)
    friendship = self.friendships_as_proposer.where(proposee_id: current_user.id)
    if friendship.empty?
      self.friendships_as_proposee.where( proposer_id: current_user.id).first.proposer_sharing_pref.capitalize
    else
      if friendship.first.proposee_sharing_pref != nil
      self.friendships_as_proposer.where(proposee_id: current_user.id).first.proposee_sharing_pref.capitalize
      else
        return nil
      end
    end
  end

  def delete_friendships_and_networks_before_destroying_user
    Friendship.where(proposer_id: self.id).each do |friendship|
      friendship.destroy
    end
    Friendship.where(proposee_id: self.id).each do |friendship|
      friendship.destroy
    end
    UserNetwork.where(user_id: self.id).each do |network|
      network.destroy
    end
  end

  def get_pref(other_user)
     f = Friendship.where({proposer_id: self.id, proposee_id: other_user.id}).first
     if f
       f.proposee_sharing_pref
     else
        Friendship.where({proposer_id: other_user.id, proposee_id: self.id}).first.proposer_sharing_pref
    end
  end



end
