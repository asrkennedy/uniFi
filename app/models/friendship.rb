class Friendship < ActiveRecord::Base
  belongs_to :proposer, class_name: "User"
  belongs_to :proposee, class_name: "User"
  attr_accessible :proposee_sharing_pref, :proposer_sharing_pref

def make_friendship
  Friendship.create proposer_id: current_user.id, proposee_id: params[@user.id], proposer_sharing_pref: params[:proposer_sharing_pref], proposee_sharing_pref: nil, confirmed: false

# validates :proposer_sharing_pref, inclusion: { in: User::SHARING_PREFERENCES }
# validates :proposee_sharing_pref, inclusion: { in: User::SHARING_PREFERENCES }

end

# def show_users
#   User.all do |user|
#     user.first_name + user.last_name
#     user.bio
#     user.user_networks.size
#     user.friends.size
#     end
# end

end
