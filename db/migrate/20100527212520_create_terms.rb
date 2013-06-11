class CreateTerms < ActiveRecord::Migration
  def self.up
    create_table :terms do |t|
      t.string :essid, :null => false
      t.string :name, :null => false
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
    
    add_index :terms, :essid, :unique => true
    add_index :terms, :start_date
  end

  def self.down
    drop_table :terms
  end
end
