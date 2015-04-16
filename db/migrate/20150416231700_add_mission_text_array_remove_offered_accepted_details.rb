class AddMissionTextArrayRemoveOfferedAcceptedDetails < ActiveRecord::Migration
  def up
    add_column :missions, :mission_text, array: true, default: []
    remove_column :missions, :offered_text
    remove_column :missions, :accepted_text
    remove_column :missions, :read_details_text
  end
  def down
    remove_column :missions, :mission_text, array: true, default: []
    add_column :missions, :offered_text, :text
    add_column :missions, :accepted_text, :text
    add_column :missions, :read_details_text, :text
  end
end
