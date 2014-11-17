class Message < ActiveRecord::Base
  belongs_to :sender, :class_name => "User", :foreign_key => "sender_id"
  belongs_to :recipient, :class_name => "User", :foreign_key => "recipient_id"
  scope :for_match,     ->(match) { where("(recipient_id = ? AND sender_id = ?) OR (recipient_id = ? AND sender_id = ? )", match.user.id, match.matched_user.id, match.matched_user.id, match.user.id)}
end
