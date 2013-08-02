class Friendship < ActiveRecord::Base
  belongs_to :proposer, class_name: "User"
  belongs_to :proposee, class_name: "User"
  attr_accessible :proposee_sharing_pref, :proposer_sharing_pref

# validates :proposer_sharing_pref, inclusion: { in: User::SHARING_PREFERENCES }
# validates :proposee_sharing_pref, inclusion: { in: User::SHARING_PREFERENCES }
end
