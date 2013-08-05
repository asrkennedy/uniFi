# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
WifiNetwork.destroy_all

User.create! first_name: 'Andrea', last_name: 'Kennedy', email: 'asrkennedy@gmail.com', password: 'password',password_confirmation: 'password', street_address: '193B Northchurch Road', postcode: 'N1 3NT', biography: 'I am a girl and I fucking love wifi apparently', role: 'admin';

User.create! first_name: 'Luke', last_name: 'Robertson', email: 'luke.robertson@mac.com', password: 'password', password_confirmation: 'password', street_address: '100 Main St', postcode: 'E1', biography: 'My name is Luke', role: 'admin';

User.create! first_name: 'Emile', last_name: 'Denichaud', email: 'denichaud@gmail.com', password: 'password', password_confirmation: 'password', street_address: '102 Main St', postcode: 'E2', biography: 'My name is Emile', role: 'admin';

User.create! first_name: 'Michael', last_name: 'Pavling', email: 'michael.pavling@gmail.com', password: 'password', password_confirmation: 'password', street_address: '103 Main St', postcode: 'E3', biography: 'My name is Michael', role: 'user';

WifiNetwork.create! latitude: '51.3', longitude: '0.38', password: 'network', password_required: 'network', postcode: 'WX', ssid: 'GA Guest', street_address: 'Back Hill', house: '9', city: 'London', country: 'UK'

WifiNetwork.create! latitude: '53.3', longitude: '0.68', password: 'network', password_required: 'network', postcode: 'W1', ssid: 'Prufrock', street_address: 'Leather Lane', house: '10', city: 'London', country: 'UK'
