class CreateWifiNetworks < ActiveRecord::Migration
  def change
    create_table :wifi_networks do |t|
      t.string :ssid
      t.string :password
      t.float :lat
      t.float :lng
      t.boolean :password_required
      t.integer :score
      t.string :street_address
      t.string :postcode

      t.timestamps
    end
  end
end
