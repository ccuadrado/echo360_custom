class CreateSections < ActiveRecord::Migration
  def self.up
    create_table :sections do |t|
      t.string :essid, :null => false
      t.string :course, :null => false
      t.string :name, :null => false
      t.boolean :section_complete
      t.boolean :publishing_complete
      t.boolean :do_not_publish
      t.boolean :default_publishers_set
      t.string :presenters, :default => '--- []'
      t.string :schedule_rules

      t.timestamps
    end
    
    add_index :sections, :essid, :unique => true
  end

  def self.down
    drop_table :sections
  end
end
