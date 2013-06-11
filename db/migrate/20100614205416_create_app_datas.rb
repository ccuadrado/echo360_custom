class CreateAppDatas < ActiveRecord::Migration
  def self.up
    create_table :app_datas do |t|
      t.string :key, :null => false
      t.string :value

      t.timestamps
    end
    
    add_index :app_datas, :key, :unique => true
  end

  def self.down
    drop_table :app_datas
  end
end
