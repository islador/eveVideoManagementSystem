class AddMonthIDtoOperations < ActiveRecord::Migration
  def up
    add_column :operations, :month_id, :integer
  end
  def down
    remove_column :operations, :month_id
  end
end
