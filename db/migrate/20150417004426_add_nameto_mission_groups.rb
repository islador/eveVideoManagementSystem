class AddNametoMissionGroups < ActiveRecord::Migration
  def up
    add_column :mission_groups, :name, :string
  end
  def down
    remove_column :mission_groups, :name
  end
end
