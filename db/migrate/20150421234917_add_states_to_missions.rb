class AddStatesToMissions < ActiveRecord::Migration
  def up
    add_column :missions, :incomplete, :boolean
    add_column :missions, :complete, :boolean
    add_column :missions, :obstructed, :boolean
  end
  def down
    remove_column :missions, :incomplete
    remove_column :missions, :complete
    remove_column :missions, :obstructed
  end
end
