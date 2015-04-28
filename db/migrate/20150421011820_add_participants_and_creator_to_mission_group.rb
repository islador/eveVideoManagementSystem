class AddParticipantsAndCreatorToMissionGroup < ActiveRecord::Migration
  def up
    add_column :mission_groups, :user_id, :integer
    add_column :mission_groups, :participants, :text, array: true, default: []
  end
  def down
    remove_column :mission_groups, :user_id
    remove_column :mission_groups, :participants
  end
end
