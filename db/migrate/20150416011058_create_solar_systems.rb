class CreateSolarSystems < ActiveRecord::Migration
  def change
    create_table :solar_systems do |t|
      t.string :solarSystemName
      t.integer :solarSystemID
      t.float :security
      t.string :missions

      t.timestamps null: false
    end
  end
end
