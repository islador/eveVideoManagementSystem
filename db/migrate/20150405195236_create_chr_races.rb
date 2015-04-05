class CreateChrRaces < ActiveRecord::Migration
  def change
    create_table :chr_races do |t|
      t.primary_key :raceID
      t.text :raceName
      t.text :description
      t.bigint :iconID
      t.shortDescription :text
      t.timestamps null: false
    end
  end
end
