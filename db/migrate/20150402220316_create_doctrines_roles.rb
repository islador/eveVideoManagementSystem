class CreateDoctrinesRoles < ActiveRecord::Migration
  def change
    create_table :doctrines_roles do |t|
      t.integer :role_id
      t.integer :doctrine_id

      t.timestamps null: false
    end
  end
end
