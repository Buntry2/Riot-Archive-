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

ActiveRecord::Schema.define(version: 20160131014736) do

  create_table "days", force: :cascade do |t|
    t.string  "date"
    t.string  "division"
    t.integer "lp"
    t.integer "score"
  end

  create_table "matches", force: :cascade do |t|
    t.string   "date"
    t.integer  "mode"
    t.boolean  "outcome"
    t.integer  "game_id"
    t.integer  "team_id"
    t.string   "champion"
    t.integer  "kills"
    t.integer  "deaths"
    t.integer  "assists"
    t.integer  "cs"
    t.float    "kda"
    t.float    "kill_participation"
    t.float    "ge"
    t.float    "dg"
    t.float    "dpg"
    t.float    "dpot"
    t.float    "gpot"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_matches", force: :cascade do |t|
    t.integer "user_id"
    t.integer "match_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password_hash"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
