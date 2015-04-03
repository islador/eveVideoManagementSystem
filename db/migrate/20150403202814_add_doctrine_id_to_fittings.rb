class AddDoctrineIdToFittings < ActiveRecord::Migration
  def up
    add_column :fittings, :doctrine_id, :integer
  end
  def down
    remove_column :fittings, :doctrine_id
  end
end
