class CreateScheduleRules < ActiveRecord::Migration
  def self.up
    create_table :schedule_rules do |t|
      t.string :essid, :null => false
      t.string :title, :null => false
      t.string :section_essid, :null => false
      t.string :section_id, :null => false
      t.string :room
      t.string :description
      t.date :start_date
      t.time :start_time
      t.integer :duration
      t.date :end_date
      t.boolean :recurring
      
      t.boolean :monday
      t.boolean :tuesday
      t.boolean :wednesday
      t.boolean :thursday
      t.boolean :friday
      t.boolean :saturday
      t.boolean :sunday
      
      t.string :excluded_dates
      t.string :presenters, :default => '--- []' #Serialised form of empty array
      t.string :captures

      t.timestamps
    end
    
    add_index :schedule_rules, :essid, :unique => true
    add_index :schedule_rules, :start_date
    
  end

  def self.down
    drop_table :schedule_rules
  end
end
