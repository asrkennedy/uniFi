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

ActiveRecord::Schema.define(:version => 20130802123055) do

  create_table "friendships", :force => true do |t|
    t.integer  "proposer_id"
    t.integer  "proposee_id"
    t.string   "proposer_sharing_pref"
    t.string   "proposee_sharing_pref"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.boolean  "confirmed"
  end

  add_index "friendships", ["proposee_id"], :name => "index_friendships_on_proposee_id"
  add_index "friendships", ["proposer_id"], :name => "index_friendships_on_proposer_id"

  create_table "sharing_preferences", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_networks", :force => true do |t|
    t.string   "nickname"
    t.integer  "wifi_network_id"
    t.integer  "user_id"
    t.string   "user_sharing_pref"
    t.integer  "user_score"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "first_name"
    t.string   "last_name"
    t.text     "biography"
    t.string   "user_image"
    t.string   "street_address"
    t.string   "postcode"
    t.string   "role"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "wifi_networks", :force => true do |t|
    t.string   "ssid"
    t.string   "password"
    t.float    "lat"
    t.float    "lng"
    t.boolean  "password_required"
    t.integer  "score"
    t.string   "street_address"
    t.string   "postcode"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

end
