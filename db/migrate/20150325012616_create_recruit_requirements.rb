class CreateRecruitRequirements < ActiveRecord::Migration
  def change
    create_table :recruit_requirements do |t|
      t.text :detail

      t.timestamps null: false
    end
  end
end
