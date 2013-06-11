class CreatePresenters < ActiveRecord::Migration
  def self.up
    create_table :presenters do |t|
      t.string :essid
      t.string :last_name
      t.string :first_name
      t.datetime :created_time
      t.string :email_address

      t.timestamps
    end

    add_index :presenters, :essid, :unique => true
    add_index :presenters, :last_name
    add_index :presenters, :first_name

  end

  def self.down
    drop_table :presenters
  end
end
