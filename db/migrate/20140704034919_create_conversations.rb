class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.string :secure_identifier
      t.timestamps
    end
  end
end
