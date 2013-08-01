class CreateUserNetworks < ActiveRecord::Migration
  def change
    create_table :user_networks do |t|
      t.string :nickname
      t.integer :wifi_network_id
      t.integer :user_id
      t.string :user_sharing_pref
      t.integer :user_score

      t.timestamps
    end
  end
end
