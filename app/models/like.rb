class Like < ActiveRecord::Base
  belongs_to :user
  has_one :user_2, :class_name => "User", :foreign_key => "user2_id"
end
