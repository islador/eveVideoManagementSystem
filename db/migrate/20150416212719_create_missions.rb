class CreateMissions < ActiveRecord::Migration
  def change
    create_table :missions do |t|
      t.text :offered_text
      t.text :accepted_text
      t.text :read_details_text
      t.string :name
      t.integer :user_id
      t.integer :fac_war_system_id
      t.integer :loyalty_points

      t.timestamps null: false
    end
  end
end
