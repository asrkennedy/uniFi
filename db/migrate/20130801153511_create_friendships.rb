class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.references :proposer
      t.references :proposee
      t.string :proposer_sharing_pref
      t.string :proposee_sharing_pref

      t.timestamps
    end
    add_index :friendships, :proposer_id
    add_index :friendships, :proposee_id
  end
end
