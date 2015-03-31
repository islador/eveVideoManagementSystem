class AddRolesHashToMembers < ActiveRecord::Migration
  def up
    add_column :members, :roles, :hstore
  end
  def down
    remove_column :members, :roles
  end
end
