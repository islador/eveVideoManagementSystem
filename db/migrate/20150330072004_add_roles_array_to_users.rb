class AddRolesArrayToUsers < ActiveRecord::Migration
  def up
    execute 'CREATE EXTENSION hstore'

    add_column :users, :roles, :hstore
    remove_column :roles, :user_id
  end

  def down
    execute 'DROP EXTENSION hstore'

    remove_coumn :users, :roles, :hstore
    add_column :roles, :user_id, :integer
  end
end
