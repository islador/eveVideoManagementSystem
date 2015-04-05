class CreateInvTypes < ActiveRecord::Migration
  def change
    create_table :invTypes, id: false do |t|
      t.primary_key :typeID
      t.bigint :groupID
      t.text :typeName
      t.text :description
      t.decimal :mass, :precision => 64, :scale => 12
      t.decimal :volume, :precision => 64, :scale => 12
      t.decimal :capacity, :precision => 64, :scale => 12
      t.bigint :portionSize
      t.decimal :basePrice, :precision => 19, :scale => 4
      t.boolean :published
      t.bigint :marketGroupID
      t.bigint :chanceofDuplicating

      t.timestamps null: false
    end
  end
end
