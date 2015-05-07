class CreateFittings < ActiveRecord::Migration
  def change
    create_table :fittings do |t|
      t.string :name
      t.string :hull
      t.string :race
      t.string :fleet_role
      t.text :description
      t.string :progression
      t.integer :progression_position
      t.string :eft_string
      t.string :ship_dna

      t.timestamps null: false
    end
  end
end
