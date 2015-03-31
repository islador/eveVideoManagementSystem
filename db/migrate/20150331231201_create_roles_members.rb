class CreateRolesMembers < ActiveRecord::Migration
  def change
    create_table :roles_members do |t|
      t.integer :role_id, index: true
      t.integer :member_id, index: true

      t.timestamps null: false
    end

    # Remove this column as it conflicts with the call to roles.
    remove_column :members, :roles
  end
end
