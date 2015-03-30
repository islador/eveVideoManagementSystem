class AddRolesArrayToUsers < ActiveRecord::Migration
  def up
    add_column :users, :roles, :hstore
    remove_column :roles, :user_id
  end

  def down
    remove_coumn :users, :roles, :hstore
    add_column :roles, :user_id, :integer
  end
end
