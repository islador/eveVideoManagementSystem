class AddMainCharToUsers < ActiveRecord::Migration
  def up
    add_column :users, :main_character_name, :string
    add_column :users, :main_character_id, :integer
  end
  def down
    remove_column :users, :main_character_id
    remove_column :users, :main_character_name
  end
end
