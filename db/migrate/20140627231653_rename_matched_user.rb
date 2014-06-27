class RenameMatchedUser < ActiveRecord::Migration
  def change
    rename_column :matches, :matched_user, :matched_user_id
  end
end
