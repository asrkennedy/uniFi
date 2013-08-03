class RemoveFieldFromWifiNetworks < ActiveRecord::Migration
  def up
    remove_column :wifi_networks, :score
  end

  def down
    add_column :wifi_networks, :score, :float
  end
end
