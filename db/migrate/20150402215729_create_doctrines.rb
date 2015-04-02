class CreateDoctrines < ActiveRecord::Migration
  def change
    create_table :doctrines do |t|
      t.string :name
      t.string :short_description
      t.text :long_description
      t.bool :access_by_hierarchy

      t.timestamps null: false
    end
  end
end
