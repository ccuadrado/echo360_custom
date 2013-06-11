# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100614205416) do

  create_table "app_datas", :force => true do |t|
    t.string   "key",        :null => false
    t.string   "value",      :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "app_datas", ["key"], :name => "index_app_datas_on_key", :unique => true

  create_table "buildings", :force => true do |t|
    t.string   "essid",      :null => false
    t.string   "campus",     :null => false
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "buildings", ["essid"], :name => "index_buildings_on_essid", :unique => true
  add_index "buildings", ["name"], :name => "index_buildings_on_name", :unique => true

  create_table "captures", :force => true do |t|
    t.string   "essid",               :null => false
    t.datetime "start_time",          :null => false
    t.integer  "duration",            :null => false
    t.string   "title",               :null => false
    t.string   "room_name",           :null => false
    t.string   "section_essid",       :null => false
    t.string   "schedule_rule_essid", :null => false
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "captures", ["essid"], :name => "index_captures_on_essid", :unique => true
  add_index "captures", ["schedule_rule_essid"], :name => "index_captures_on_schedule_rule_essid", :unique => true
  add_index "captures", ["start_time"], :name => "index_captures_on_start_time", :unique => true

  create_table "courses", :force => true do |t|
    t.string   "essid",      :null => false
    t.string   "name",       :null => false
    t.string   "identifier", :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "courses", ["essid"], :name => "index_courses_on_essid", :unique => true
  add_index "courses", ["identifier"], :name => "index_courses_on_identifier", :unique => true
  add_index "courses", ["name"], :name => "index_courses_on_name", :unique => true

  create_table "presenters", :force => true do |t|
    t.string   "essid",         :null => false
    t.string   "last_name",     :null => false
    t.string   "first_name",    :null => false
    t.datetime "created_time",  :null => false
    t.string   "email_address", :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "presenters", ["essid"], :name => "index_presenters_on_essid", :unique => true
  add_index "presenters", ["first_name"], :name => "index_presenters_on_first_name", :unique => true
  add_index "presenters", ["last_name"], :name => "index_presenters_on_last_name", :unique => true

  create_table "rooms", :force => true do |t|
    t.string   "essid",      :null => false
    t.string   "name",       :null => false
    t.string   "building",   :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "rooms", ["essid"], :name => "index_rooms_on_essid", :unique => true

  create_table "schedule_rules", :force => true do |t|
    t.string   "essid",                                :null => false
    t.string   "title",                                :null => false
    t.string   "section_essid",                        :null => false
    t.string   "section_id",                           :null => false
    t.string   "room",                                 :null => false
    t.string   "description",                          :null => false
    t.date     "start_date",                           :null => false
    t.time     "start_time",                           :null => false
    t.integer  "duration",                             :null => false
    t.date     "end_date",                             :null => false
    t.boolean  "recurring",                            :null => false
    t.boolean  "monday",                               :null => false
    t.boolean  "tuesday",                              :null => false
    t.boolean  "wednesday",                            :null => false
    t.boolean  "thursday",                             :null => false
    t.boolean  "friday",                               :null => false
    t.boolean  "saturday",                             :null => false
    t.boolean  "sunday",                               :null => false
    t.string   "excluded_dates",                       :null => false
    t.string   "presenters",     :default => "--- []", :null => false
    t.string   "captures",                             :null => false
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
  end

  add_index "schedule_rules", ["essid"], :name => "index_schedule_rules_on_essid", :unique => true
  add_index "schedule_rules", ["start_date"], :name => "index_schedule_rules_on_start_date", :unique => true

  create_table "sections", :force => true do |t|
    t.string   "essid",                                        :null => false
    t.string   "course",                                       :null => false
    t.string   "name",                                         :null => false
    t.boolean  "section_complete",                             :null => false
    t.boolean  "publishing_complete",                          :null => false
    t.boolean  "do_not_publish",                               :null => false
    t.boolean  "default_publishers_set",                       :null => false
    t.string   "presenters",             :default => "--- []", :null => false
    t.string   "schedule_rules",                               :null => false
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
  end

  add_index "sections", ["essid"], :name => "index_sections_on_essid", :unique => true

  create_table "terms", :force => true do |t|
    t.string   "essid",      :null => false
    t.string   "name",       :null => false
    t.datetime "start_date", :null => false
    t.datetime "end_date",   :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "terms", ["essid"], :name => "index_terms_on_essid", :unique => true
  add_index "terms", ["start_date"], :name => "index_terms_on_start_date", :unique => true

end
