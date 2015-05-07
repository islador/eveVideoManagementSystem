class CreateChrRaces < ActiveRecord::Migration
  def change
    create_table :chrRaces, id: false do |t|
      t.primary_key :raceID
      t.text :raceName
      t.text :description
      t.bigint :iconID
      t.text :shortDescription
      t.timestamps null: false
    end
  end
end
