class CreateMembersRoles < ActiveRecord::Migration
  def change
    create_table :members_roles do |t|
      t.integer :member_id, index: true
      t.integer :role_id, index: true

      t.timestamps null: false
      disable_extension "hstore"
    end
  end
end
