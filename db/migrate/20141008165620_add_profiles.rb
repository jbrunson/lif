class AddProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.text :about_me
      t.timestamps
    end

  end
end
