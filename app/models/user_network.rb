class UserNetwork < ActiveRecord::Base
  attr_accessible :nickname, :user_id, :user_score, :user_sharing_pref, :wifi_network_id, :wifi_network_attributes
  belongs_to :wifi_network
  belongs_to :user

  validates :user_sharing_pref, inclusion: { in: User::SHARING_PREFERENCES }
  validates_uniqueness_of :user_id, scope: [:wifi_network_id]
  validates :nickname, presence: true
  validates :user_score, presence: true
  accepts_nested_attributes_for :wifi_network

  def address
    "#{self.wifi_network.house}, #{self.wifi_network.street_address}, #{self.wifi_network.city}, #{self.wifi_network.postcode}, #{self.wifi_network.country}"
  end

  def sharing_string
    case self.user_sharing_pref
      when "public" then x = "Public"
      when "private" then return "This network is private, only you can see it"
      when "acquaintance" then x = "Acquaintances, Friends and Close Friends"
      when "friend" then x = "Friends and Close friends"
      when "close friend" then x = "Close Friends"
    end
    "Visibility: #{x}"
  end

  def rating_string
    "Your rating: #{user_score} out of 5 (average Uni-Fi user rating: #{self.wifi_network.average_user_rating})"
  end

  def shareable_with(user)
    owner_friendship_as_proposer = Friendship.where({proposer_id: self.user_id, proposee_id: user.id}).first
    owner_friendship_as_proposee = Friendship.where({proposee_id: self.user_id, proposer_id: user.id}).first

    case self.user_sharing_pref
      when "public" then return false
      # public networks are displayed in a different area
      when "private" then return false
      when "acquaintance" then
        if owner_friendship_as_proposer
          ["acquaintance", "friend", "close friend"].include?(owner_friendship_as_proposer.proposer_sharing_pref)
        elsif owner_friendship_as_proposee
          ["acquaintance", "friend", "close friend"].include?(owner_friendship_as_proposee.proposee_sharing_pref)
        end
      when "friend" then
        if owner_friendship_as_proposer
          ["friend", "close friend"].include?(owner_friendship_as_proposer.proposer_sharing_pref)
        elsif owner_friendship_as_proposee
          ["friend", "close friend"].include?(owner_friendship_as_proposee.proposee_sharing_pref)
        end
      when "close friend" then
        if owner_friendship_as_proposer
          owner_friendship_as_proposer.proposer_sharing_pref == "close friend"
        elsif owner_friendship_as_proposee
          owner_friendship_as_proposee.proposee_sharing_pref == "close friend"
        end
      else
        return false
    end
end




end