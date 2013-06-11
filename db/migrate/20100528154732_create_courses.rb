class CreateCourses < ActiveRecord::Migration
  def self.up
    create_table :courses do |t|
      t.string :essid, :null => false
      t.string :name, :null => false
      t.string :identifier, :null => false

      t.timestamps
    end

    add_index :courses, :essid, :unique => true
    add_index :courses, :name
    add_index :courses, :identifier, :unique => true

  end

  def self.down
    drop_table :courses
  end
end
