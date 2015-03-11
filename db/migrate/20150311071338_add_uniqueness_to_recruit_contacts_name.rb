class AddUniquenessToRecruitContactsName < ActiveRecord::Migration
  def up
    add_index :recruit_contacts, :name, :unique => true
  end
  def down
    #This may not work. Test it and find out!
    remove_index :recruit_contacts, :name
  end
end
