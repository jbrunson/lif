class ChangeUser2IdOnLikesTable < ActiveRecord::Migration
  def change
    rename_column :likes, :user2_id, :liked_user
  end
end
