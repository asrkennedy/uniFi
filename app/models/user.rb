class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :street_address, :postcode, :biography, :user_image, :role

  has_many :friendships_as_proposer, class_name: "Friendship", foreign_key: :proposer_id
  has_many :friendships_as_proposee, class_name: "Friendship", foreign_key: :proposee_id
  has_many :user_networks

  def friends_networks

  proposee_networks = self.friendships_as_proposer.each do |friendship|
      friendship.proposee.user_networks.map do |network|
        network.wifi_network
      end
    end

    proposer_networks = self.friendships_as_proposee.all.each do |friendship|
      friendship.proposer.user_networks.map do |network|
        network.wifi_network
      end
    end

    proposer_networks + proposee_networks
  end


end
