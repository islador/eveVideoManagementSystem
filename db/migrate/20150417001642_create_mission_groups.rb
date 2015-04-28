class CreateMissionGroups < ActiveRecord::Migration
  def change
    create_table :mission_groups do |t|

      t.timestamps null: false
    end
  end
end
