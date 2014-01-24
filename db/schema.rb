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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140124014301) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "matches", force: true do |t|
    t.integer  "team_1_id"
    t.integer  "team_2_id"
    t.string   "type"
    t.date     "date"
    t.string   "city"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "stadium_id"
  end

  create_table "stadia", force: true do |t|
    t.string   "name"
    t.string   "city"
    t.string   "country"
    t.string   "picture"
    t.string   "capacity"
    t.integer  "home_team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", force: true do |t|
    t.string   "country"
    t.string   "country_ab"
    t.string   "flag"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "group_id"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_reset_token"
    t.datetime "password_expires_after"
  end

end
