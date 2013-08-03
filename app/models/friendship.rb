class Friendship < ActiveRecord::Base
  belongs_to :proposer, class_name: "User"
  belongs_to :proposee, class_name: "User"
  attr_accessible :proposee_sharing_pref, :proposer_sharing_pref, :proposee_id, :proposer_id



# def show_users
#   User.all do |user|
#     user.first_name + user.last_name
#     user.bio
#     user.user_networks.size
#     user.friends.size
#     end
# end

end
