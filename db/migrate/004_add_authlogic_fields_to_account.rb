class AddAuthlogicFieldsToAccount < ActiveRecord::Migration
  def self.up
    change_table :accounts do |t|
      t.string :persistence_token, :null => false
      t.integer :login_count, :default => 0, :null => false
      t.datetime :last_request_at
      t.datetime :last_login_at
      t.datetime :current_login_at
      t.string :last_login_ip
      t.string :current_login_ip
    end
  end

  def self.down
    change_table :accounts do |t|
      t.remove :persistence_token
      t.remove :login_count
      t.remove :last_request_at
      t.remove :last_login_at
      t.remove :current_login_at
      t.remove :last_login_ip
      t.remove :current_login_ip
    end
  end
end
