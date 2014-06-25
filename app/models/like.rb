class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :liked_user, :class_name => "User", :foreign_key => "liked_user"

end
