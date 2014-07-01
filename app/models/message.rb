class Message < ActiveRecord::Base

  scope :for_match,     ->(match) { where("(recipient_id = ? AND sender_id = ?) OR (recipient_id = ? AND sender_id = ?)", match.user.id, match.matched_user.id, match.matched_user.id, match.user.id)}
end
