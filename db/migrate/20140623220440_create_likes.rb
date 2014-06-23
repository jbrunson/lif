class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.references :user
      t.integer :user2_id
      t.timestamps
    end
  end
end
