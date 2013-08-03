class ChangeDataTypeForScoreInWifiNetworks < ActiveRecord::Migration
  def up
    change_column :wifi_networks, :score, :float
  end

  def down
    change_column :wifi_networks, :score, :integer
  end
end
