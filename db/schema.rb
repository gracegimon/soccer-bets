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

ActiveRecord::Schema.define(version: 20140410023456) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "extra_phases", force: true do |t|
    t.integer  "score_board_id"
    t.integer  "penal_team_id"
    t.integer  "red_card_team_id"
    t.integer  "best_player_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "extra_phases", ["score_board_id"], name: "index_extra_phases_on_score_board_id", using: :btree

  create_table "group_matches", force: true do |t|
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "match_id"
  end

  create_table "group_teams", force: true do |t|
    t.integer  "group_id"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", force: true do |t|
    t.string   "name"
    t.integer  "first_place_team_id"
    t.integer  "second_place_team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tournament_id"
  end

  create_table "matches", force: true do |t|
    t.integer  "team_1_id"
    t.integer  "team_2_id"
    t.string   "city"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "stadium_id"
    t.integer  "match_type"
    t.datetime "date"
    t.integer  "score_board_id"
    t.integer  "match_number"
  end

  add_index "matches", ["match_type"], name: "index_matches_on_match_type", using: :btree
  add_index "matches", ["score_board_id"], name: "index_matches_on_score_board_id", using: :btree

  create_table "players", force: true do |t|
    t.date     "date_of_birth"
    t.string   "position"
    t.integer  "shirt_number"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "players", ["name"], name: "index_players_on_name", using: :btree

  create_table "score_boards", force: true do |t|
    t.integer  "user_id"
    t.integer  "position"
    t.integer  "points"
    t.boolean  "is_active"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "name"
    t.integer  "board_type"
    t.integer  "tournament_id"
    t.boolean  "is_published"
  end

  add_index "score_boards", ["is_active"], name: "index_score_boards_on_is_active", using: :btree
  add_index "score_boards", ["points"], name: "index_score_boards_on_points", order: {"points"=>:desc}, using: :btree
  add_index "score_boards", ["user_id"], name: "index_score_boards_on_user_id", using: :btree

  create_table "scores", force: true do |t|
    t.integer  "team_1_goals"
    t.integer  "team_2_goals"
    t.integer  "winner_team_id"
    t.integer  "scoreboard_id"
    t.integer  "match_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "can_change",     default: true
  end

  add_index "scores", ["match_id"], name: "index_scores_on_match_id", using: :btree

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

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

  create_table "team_stats", force: true do |t|
    t.integer  "team_id"
    t.integer  "points"
    t.integer  "status"
    t.integer  "played_games"
    t.integer  "won_games"
    t.integer  "tied_games"
    t.integer  "goals_favor"
    t.integer  "goals_aggainst"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "score_board_id"
    t.integer  "lost_games"
    t.integer  "position"
  end

  add_index "team_stats", ["score_board_id"], name: "index_team_stats_on_score_board_id", using: :btree

  create_table "teams", force: true do |t|
    t.string   "country"
    t.string   "country_ab"
    t.string   "flag"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "city"
    t.string   "league"
  end

  add_index "teams", ["name"], name: "index_teams_on_name", using: :btree

  create_table "tournaments", force: true do |t|
    t.string   "name"
    t.string   "number"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tournament_type"
    t.integer  "is_active"
    t.integer  "current_phase"
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
    t.boolean  "is_admin"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree

end
