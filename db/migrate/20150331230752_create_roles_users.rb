class CreateRolesUsers < ActiveRecord::Migration
  def change
    create_table :roles_users do |t|
      t.integer :role_id, index: true
      t.integer :user_id, index: true

      t.timestamps null: false
    end

    # Remove this column as it conflicts with the call to roles.
    remove_column :users, :roles
  end
end
