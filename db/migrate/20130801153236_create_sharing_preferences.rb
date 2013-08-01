class CreateSharingPreferences < ActiveRecord::Migration
  def change
    create_table :sharing_preferences do |t|
      t.string :name

      t.timestamps
    end
  end
end
