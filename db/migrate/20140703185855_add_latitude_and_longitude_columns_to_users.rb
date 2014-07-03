class AddLatitudeAndLongitudeColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_latitude, :float
    add_column :users, :last_longitude, :float
  end
end
