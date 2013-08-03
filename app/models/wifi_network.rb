class WifiNetwork < ActiveRecord::Base
  attr_accessible :latitude, :longitude, :password, :password_required, :postcode, :score, :ssid, :street_address
  has_many :user_networks

  geocoded_by :full_street_address
  after_validation :geocode


  def full_street_address
    "#{self.street_address}, #{self.postcode}, United Kingdom"
  end


end
