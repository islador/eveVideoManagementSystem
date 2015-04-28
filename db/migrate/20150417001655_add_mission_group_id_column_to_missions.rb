class AddMissionGroupIdColumnToMissions < ActiveRecord::Migration
  def up
    add_column :missions, :mission_group_id, :integer
  end
  def down
    remove_column :missions, :mission_group_id
  end
end
