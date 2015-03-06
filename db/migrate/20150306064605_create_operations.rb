class CreateOperations < ActiveRecord::Migration
  def change
    create_table :operations do |t|
      t.string :name
      t.date :eve_date
      t.text :ships, array: true, default: []
      t.string :doctrine
      t.string :fleet_commander
      t.datetime :eve_time
      t.string :voice_coms_server
      t.string :voice_coms_server_channel
      t.string :rally_point
      t.text :specialty_roles, array: true, default: []

      t.timestamps null: false
    end
  end
end
