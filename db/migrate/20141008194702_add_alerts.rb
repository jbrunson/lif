class AddAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
      t.integer :user_id
      t.integer :match_id
      t.boolean :has_been_seen, default: false
      t.timestamps
    end
  end
end
