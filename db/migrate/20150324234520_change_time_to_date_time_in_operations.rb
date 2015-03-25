class ChangeTimeToDateTimeInOperations < ActiveRecord::Migration
  def up
    remove_column :operations, :op_prep_start
    remove_column :operations, :op_departure
    remove_column :operations, :op_completion

    add_column :operations, :op_prep_start, :datetime
    add_column :operations, :op_departure, :datetime
    add_column :operations, :op_completion, :datetime
  end

  def down
    change_column :operations, :op_prep_start, :time
    change_column :operations, :op_departure, :time
    change_column :operations, :op_completion, :time
  end
end
