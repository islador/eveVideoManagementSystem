class AddDefaultsToFleetCommander < ActiveRecord::Migration
  def up
    change_column :fleet_commanders, :overall_rating, :integer, :default => 0
    change_column :fleet_commanders, :fun_rating, :integer, :default => 0
    change_column :fleet_commanders, :communication_clarity_rating, :integer, :default => 0
    change_column :fleet_commanders, :noob_friendly_rating, :integer, :default => 0
    change_column :fleet_commanders, :target_selection_rating, :integer, :default => 0
    change_column :fleet_commanders, :friendly_rating, :integer, :default => 0
  end
  def down
    change_column :fleet_commanders, :overall_rating, :integer
    change_column :fleet_commanders, :fun_rating, :integer
    change_column :fleet_commanders, :communication_clarity_rating, :integer
    change_column :fleet_commanders, :noob_friendly_rating, :integer
    change_column :fleet_commanders, :target_selection_rating, :integer
    change_column :fleet_commanders, :friendly_rating, :integer
  end
end
