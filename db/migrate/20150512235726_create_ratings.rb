class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.string :name
      t.integer :user_id
      t.integer :fleet_commander_id
      t.integer :score, default: 0

      t.timestamps null: false
    end
  end
end
