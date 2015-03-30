class CleanupUsersTable < ActiveRecord::Migration
  def up
    remove_index :users, :email
    remove_index :users, :reset_password_token
    remove_index :users, :confirmation_token
    remove_index :users, :unlock_token

    remove_column :users, :email
    remove_column :users, :encrypted_password

    remove_column :users, :reset_password_token
    remove_column :users, :reset_password_sent_at

    remove_column :users, :remember_created_at

    remove_column :users, :confirmation_token
    remove_column :users, :confirmed_at
    remove_column :users, :confirmation_sent_at
    remove_column :users, :unconfirmed_email

    remove_column :users, :failed_attempts
    remove_column :users, :unlock_token
    remove_column :users, :locked_at
  end

  def down
    add_column :users, :email, :string
    add_column :users, :encrypted_password, :string

    add_column :users, :reset_password_token, :string
    add_column :users, :reset_password_sent_at, :datetime

    add_column :users, :remember_created_at, :datetime

    add_column :users, :confirmation_token, :string
    add_column :users, :confirmed_at, :datetime
    add_column :users, :confirmation_sent_at, :datetime
    add_column :users, :unconfirmed_email, :string

    add_column :users, :failed_attempts, :integer
    add_column :users, :unlock_token, :string
    add_column :users, :locked_at, :datetime

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :confirmation_token,   unique: true
    add_index :users, :unlock_token,         unique: true
  end
end
