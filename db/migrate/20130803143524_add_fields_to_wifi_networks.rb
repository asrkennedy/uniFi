class AddFieldsToWifiNetworks < ActiveRecord::Migration
  def change
    add_column :wifi_networks, :house, :string
    add_column :wifi_networks, :city, :string
    add_column :wifi_networks, :country, :string
  end
end
