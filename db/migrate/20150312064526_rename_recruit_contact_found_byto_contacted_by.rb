class RenameRecruitContactFoundBytoContactedBy < ActiveRecord::Migration
  def up
    rename_column :recruit_contacts, :found_by, :contacted_by
  end
  def down
    rename_column :recruit_contacts, :contacted_by, :found_by
  end
end
