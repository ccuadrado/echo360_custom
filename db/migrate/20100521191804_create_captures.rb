class CreateCaptures < ActiveRecord::Migration
  def self.up
    create_table :captures do |t|
      t.string :essid
      t.datetime :start_time
      t.integer :duration
      t.string :title
      t.string :room_name
      t.string :section_essid
      t.string :schedule_rule_essid

      t.timestamps
    end
    
    add_index :captures, :essid, :unique => true
    add_index :captures, :start_time
    add_index :captures, :schedule_rule_essid
    
  end

  def self.down
    drop_table :captures
  end
end
