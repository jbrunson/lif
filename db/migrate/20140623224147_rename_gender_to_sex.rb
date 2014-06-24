class RenameGenderToSex < ActiveRecord::Migration
  def change
    rename_column :users, :gender, :sex
  end
end
