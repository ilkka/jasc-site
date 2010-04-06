class RenameSaltInAccountToPasswordSalt < ActiveRecord::Migration
  def self.up
    rename_column :accounts, :salt, :password_salt
  end

  def self.down
    rename_column :accounts, :password_salt, :salt
  end
end
