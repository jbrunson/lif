class ChangeMatchesTable < ActiveRecord::Migration
  def change
    rename_column :matches, :user2_id, :matched_user
    rename_column :matches, :user1_id, :user_id
  end
end
