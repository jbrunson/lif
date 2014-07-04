class Match < ActiveRecord::Base
  belongs_to :user
  belongs_to :matched_user, :class_name => "User", :foreign_key => "matched_user_id"
  belongs_to :conversation
  scope :for_user,     ->(user) { where("(user_id = ? OR matched_user_id = ?)", user.id, user.id)}
end
