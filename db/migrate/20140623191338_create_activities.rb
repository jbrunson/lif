class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.date :arrival_date
      t.date :departure_date
      t.string :location
      t.references :user

      t.timestamps
    end
  end
end
