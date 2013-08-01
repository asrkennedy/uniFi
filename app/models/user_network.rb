class UserNetwork < ActiveRecord::Base
  attr_accessible :nickname, :user_id, :user_score, :user_sharing_pref, :wifi_network_id
  belongs_to :wifi_network
  belongs_to :user
end
