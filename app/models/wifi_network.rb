class WifiNetwork < ActiveRecord::Base
  attr_accessible :lat, :lng, :password, :password_required, :postcode, :score, :ssid, :street_address
  has_many :user_networks
end
