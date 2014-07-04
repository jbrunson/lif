class AddUserMatchesJoinTable < ActiveRecord::Migration
  def change
    remove_column :matches, :user_id
    remove_column :matches, :matched_user_id
    create_join_table :matches, :users
  end



end
