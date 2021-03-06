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

ActiveRecord::Schema.define(version: 20160621033912) do

  create_table "challenges", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "entry_id"
    t.string   "oj"
    t.string   "pid"
    t.string   "title"
    t.integer  "points"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "challenges", ["entry_id"], name: "index_challenges_on_entry_id"
  add_index "challenges", ["user_id"], name: "index_challenges_on_user_id"

  create_table "challengestatuses", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "challenge_id"
    t.string   "status"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "challengestatuses", ["challenge_id"], name: "index_challengestatuses_on_challenge_id"
  add_index "challengestatuses", ["user_id"], name: "index_challengestatuses_on_user_id"

  create_table "entries", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "calendarid"
    t.datetime "target"
    t.string   "message"
    t.string   "status"
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "entries", ["target"], name: "index_entries_on_target"
  add_index "entries", ["user_id"], name: "index_entries_on_user_id"

  create_table "userprofiles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "userprofiles", ["user_id"], name: "index_userprofiles_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "image"
    t.string   "token"
    t.string   "email"
    t.datetime "expires_at"
    t.string   "role"
    t.string   "displayname"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

end
