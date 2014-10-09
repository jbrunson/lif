class AddProfilesToExistingUsers < ActiveRecord::Migration
  def change
    User.all.each do |user|
      user.create_profile
    end
  end
end
