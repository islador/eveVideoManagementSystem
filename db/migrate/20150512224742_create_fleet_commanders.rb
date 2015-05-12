class CreateFleetCommanders < ActiveRecord::Migration
  def change
    create_table :fleet_commanders do |t|
      t.fixnum :overall_rating
      t.fixnum :fun_rating
      t.fixnum :communication_clarity_rating
      t.fixnum :noob_friendly_rating
      t.fixnum :target_selection_rating
      t.fixnum :friendly_rating

      t.timestamps null: false
    end
  end
end
