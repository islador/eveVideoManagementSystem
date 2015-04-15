class CreateFacWarSystems < ActiveRecord::Migration
  def change
    create_table :fac_war_systems do |t|
      t.integer :solarSystemID
      t.string :solarSystemName
      t.integer :occupyingFactionID
      t.integer :owningFactionID
      t.string :occupyingFactionName
      t.string :owningFactionName
      t.boolean :contested
      t.integer :victoryPoints
      t.integer :victoryPointThreshold

      t.timestamps null: false
    end
  end
end
