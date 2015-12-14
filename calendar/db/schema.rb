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

ActiveRecord::Schema.define(version: 20151212225351) do

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
