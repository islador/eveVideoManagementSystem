class CreateWarCombatZoneSystems < ActiveRecord::Migration
  def change
    create_table :warCombatZoneSystems, id: false do |t|
      t.primary_key :solarSystemID
      t.bigint :combatZoneID

      t.timestamps null: false
    end
  end
end
