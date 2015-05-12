class AddNameLanguageToFleetCommander < ActiveRecord::Migration
  def up
    add_column :fleet_commanders, :name, :string
    add_column :fleet_commanders, :language, :string
  end
  def down
    remove_column :fleet_commanders, :name
    remove_column :fleet_commanders, :language
  end
end
