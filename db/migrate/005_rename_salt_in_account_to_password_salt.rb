class RenameSaltInAccountToPasswordSalt < ActiveRecord::Migration
  def self.up
    change_table :accounts do |t|
      t.rename_column :salt, :password_salt
    end
  end

  def self.down
    change_table :accounts do |t|
      t.rename_column :password_salt, :salt
    end
  end
end
