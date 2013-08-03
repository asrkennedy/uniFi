class UserNetwork < ActiveRecord::Base
  attr_accessible :nickname, :user_id, :user_score, :user_sharing_pref, :wifi_network_id, :wifi_network_attributes
  belongs_to :wifi_network
  belongs_to :user

  validates :user_sharing_pref, inclusion: { in: User::SHARING_PREFERENCES }
  accepts_nested_attributes_for :wifi_network


  def shareable_with(user)
    owner_friendship_as_proposer = Friendship.where({proposer_id: self.user_id, proposee_id: user.id}).first
    owner_friendship_as_proposee = Friendship.where({proposee_id: self.user_id, proposer_id: user.id}).first
    case self.user_sharing_pref
      when "public" then return true
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