class WifiNetwork < ActiveRecord::Base
  attr_accessible :latitude, :longitude, :password, :password_required, :postcode, :ssid, :street_address, :house, :city, :country
  has_many :user_networks

  geocoded_by :full_street_address
  after_validation :geocode, :if => :address_changed?


  def full_street_address
    "#{self.house}, #{self.street_address}, #{self.city}, #{self.postcode}, #{self.country}"
  end


  def average_user_rating
    if self.user_networks.length >0
      total_score = 0
      self.user_networks.each do |user_network|
        total_score += user_network.user_score.to_f
      end
      (total_score/self.user_networks.count).round(2)
    else
      "Undefined"
    end
  end

  def rating_string
    "Average Uni-Fi user rating: #{self.average_user_rating}"
  end

  def is_public
    self.user_networks.map{|network| network.user_sharing_pref }.include?("public")
  end

  def is_not_a_user_network_of(user)
    !((self.user_networks.map{|network| network.user_id}).include?(user.id))
  end

  def address_changed?
    house_changed? || street_address_changed? || city_changed? || postcode_changed? || country_changed?
  end

end
