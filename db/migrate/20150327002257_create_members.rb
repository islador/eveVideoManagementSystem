class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.integer :characterID
      t.string :name
      t.datetime :startDateTime
      t.integer :baseID
      t.string :base
      t.string :title
      t.datetime :logonDateTime
      t.datetime :logoffDateTime

      t.timestamps null: false
    end
  end
end
