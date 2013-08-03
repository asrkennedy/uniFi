class ChangeLatLngInWifiNetworks < ActiveRecord::Migration
  def change
    rename_column :wifi_networks, :lat, :latitude
    rename_column :wifi_networks, :lng, :longitude
  end


end
