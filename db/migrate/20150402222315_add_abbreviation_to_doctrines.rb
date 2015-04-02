class AddAbbreviationToDoctrines < ActiveRecord::Migration
  def up
    add_column :doctrines, :abbreviation, :string
  end
  def down
    remove_column :doctrines, :abbreviation
  end
end
