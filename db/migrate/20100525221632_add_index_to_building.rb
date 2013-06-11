class AddIndexToBuilding < ActiveRecord::Migration
  def self.up
    add_index :buildings, :essid
    add_index :buildings, :name
  end

  def self.down
    remove_index :buildings, :essid
    remove_index :buildings, :name
  end
end
