class CreateFleetCommanders < ActiveRecord::Migration
  def change
    create_table :fleet_commanders do |t|
      t.integer :overall_rating
      t.integer :fun_rating
      t.integer :communication_clarity_rating
      t.integer :noob_friendly_rating
      t.integer :target_selection_rating
      t.integer :friendly_rating

      t.timestamps null: false
    end
  end
end
