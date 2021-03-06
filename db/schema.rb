# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120525205252) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "carriers", :force => true do |t|
    t.string   "name"
    t.integer  "city_id"
    t.string   "address"
    t.string   "phone"
    t.string   "telephone"
    t.string   "fax"
    t.string   "email"
    t.string   "web_site"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "cities", :force => true do |t|
    t.string   "name"
    t.integer  "country_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "departure_dates", :force => true do |t|
    t.date     "day_of_life"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "departures", :force => true do |t|
    t.string   "trip_number"
    t.integer  "departure_date_id"
    t.integer  "ticket_id"
    t.boolean  "direction"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "health_insurance_prices", :force => true do |t|
    t.integer  "ticket_id"
    t.integer  "adult"
    t.integer  "child"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "one_way_prices", :force => true do |t|
    t.integer  "ticket_id"
    t.integer  "adult"
    t.integer  "child"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "one_way_visa_prices", :force => true do |t|
    t.integer  "ticket_id"
    t.integer  "adult"
    t.integer  "child"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 8
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "requests", :force => true do |t|
    t.integer  "city_from_id"
    t.integer  "city_to_id"
    t.boolean  "one_way"
    t.boolean  "visa"
    t.integer  "adult"
    t.integer  "child"
    t.string   "name"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.date     "date_from"
    t.date     "date_to"
    t.string   "notice"
  end

  create_table "reservations", :force => true do |t|
    t.integer  "city_from_id"
    t.integer  "city_to_id"
    t.integer  "departure_from_id"
    t.integer  "departure_to_id"
    t.boolean  "one_way"
    t.boolean  "visa"
    t.integer  "adult"
    t.integer  "child"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "name"
  end

  create_table "tickets", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "carrier_id"
  end

  create_table "two_ways_prices", :force => true do |t|
    t.integer  "ticket_id"
    t.integer  "adult"
    t.integer  "child"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "two_ways_visa_prices", :force => true do |t|
    t.integer  "ticket_id"
    t.integer  "adult"
    t.integer  "child"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "visa_prices", :force => true do |t|
    t.integer  "ticket_id"
    t.integer  "adult"
    t.integer  "child"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "ways", :force => true do |t|
    t.integer  "city_id"
    t.integer  "ticket_id"
    t.boolean  "direction"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "place_stop"
    t.time     "time_stop"
  end

end
