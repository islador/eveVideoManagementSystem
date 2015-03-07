class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :name
      t.date :filmed_on
      t.integer :operation_id
      t.string :s3_url
      t.string :kind

      t.timestamps null: false
    end
  end
end
