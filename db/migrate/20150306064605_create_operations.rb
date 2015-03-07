class CreateOperations < ActiveRecord::Migration
  def change
    create_table :operations do |t|
      t.string :name
      t.date :op_date
      t.time :op_prep_start
      t.time :op_departure
      t.time :op_completion
      t.text :ships, array: true, default: []
      t.string :doctrine
      t.string :fleet_commander
      t.string :voice_coms_server
      t.string :voice_coms_server_channel
      t.string :rally_point
      t.text :specialty_roles, array: true, default: []

      t.timestamps null: false
    end
  end
end
