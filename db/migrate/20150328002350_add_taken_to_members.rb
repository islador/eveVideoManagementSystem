class AddTakenToMembers < ActiveRecord::Migration
  def up
    add_column :members, :taken, :boolean
    add_column :members, :user_id, :integer
  end
  def down
    remove_column :members, :taken
    remove_column :members, :user_id
  end
end
