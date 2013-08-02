class UserNetwork < ActiveRecord::Base
  attr_accessible :nickname, :user_id, :user_score, :user_sharing_pref, :wifi_network_id
  belongs_to :wifi_network
  belongs_to :user



  def shareable_with(user)

    owner_friendship_as_proposer = Friendship.where({proposer_id: self.user_id, proposee_id: user.id}).first
    owner_friendship_as_proposee = Friendship.where({proposee_id: self.user_id, proposer_id: user.id}).first

    if owner_friendship_as_proposer
      owner_friendship_as_proposer.proposer_sharing_pref == self.user_sharing_pref || self.user_sharing_pref == "public"
    elsif owner_friendship_as_proposee
      owner_friendship_as_proposee.proposee_sharing_pref == self.user_sharing_pref || self.user_sharing_pref == "public"
    end
  end

end