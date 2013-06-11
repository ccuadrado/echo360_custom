class CreateRooms < ActiveRecord::Migration
  def self.up
    create_table :rooms do |t|
      t.string :essid
      t.string :name
      t.string :building
      
      t.timestamps
    end
    
    add_index :rooms, :essid, :unique => true

  end

  def self.down
    drop_table :rooms
  end
end
