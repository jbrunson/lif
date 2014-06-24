class AddMatchPreferenceToUsers < ActiveRecord::Migration
  def change
    add_column :users, :match_preference, :string
  end
end
