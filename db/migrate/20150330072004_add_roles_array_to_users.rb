class AddRolesArrayToUsers < ActiveRecord::Migration
  def up
    enable_extension "hstore"

    add_column :users, :roles, :hstore
    remove_column :roles, :user_id
  end

  def down
    disable_extension "hstore"

    remove_coumn :users, :roles, :hstore
    add_column :roles, :user_id, :integer
  end
end
