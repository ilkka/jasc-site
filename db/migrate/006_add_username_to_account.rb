class AddUsernameToAccount < ActiveRecord::Migration
  def self.up
    change_table :accounts do |t|
      t.string :username
    end
  end

  def self.down
    change_table :accounts do |t|
      t.remove :username
    end
  end
end
