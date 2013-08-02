require 'populator'
require 'faker'

namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do

    Faker::Config.locale = "en-gb"
    [WifiNetwork, UserNetwork, User].each(&:delete_all)

    WifiNetwork.populate 20 do |wifi_network|
      wifi_network.ssid = Populator.words(1).titleize
      wifi_network.street_address  = Faker::Address.street_address
      wifi_network.postcode     = Faker::Address.postcode
      wifi_network.lat = Faker::Address.latitude
      wifi_network.lng = Faker::Address.longitude
      wifi_network.created_at = 2.years.ago..Time.now
      wifi_network.updated_at = 2.years.ago..Time.now
      wifi_network.password = Populator.words(1)

    end

    User.populate 20 do |user|
      user.first_name    = Faker::Name.first_name
      user.last_name    = Faker::Name.last_name
      user.email   = Faker::Internet.email
      user.biography   = Populator.sentences(2..10)
      user.street_address  = Faker::Address.street_address
      user.postcode     = Faker::Address.postcode
      user.encrypted_password = User.new(password: 'password', password_confirmation: 'password').encrypted_password
    end
    # users=User.all
    # (0..50).each do |i|
    # users.shuffle
    # Friendship.create proposer_id: users[0].id, proposee_id: users[1].id
    # end
  end
end