class CreateRecruitContacts < ActiveRecord::Migration
  def change
    create_table :recruit_contacts do |t|
      t.string :name
      t.string :found_by
      t.string :conversation_type
      t.string :timezone
      t.text :conclusion

      t.timestamps null: false
    end
  end
end
