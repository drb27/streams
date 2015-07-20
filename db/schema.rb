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

ActiveRecord::Schema.define(version: 20150720112200) do

  create_table "goalcomments", force: :cascade do |t|
    t.string   "headline"
    t.string   "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "goal_id"
    t.integer  "user_id"
  end

  create_table "goals", force: :cascade do |t|
    t.string   "name"
    t.date     "target"
    t.boolean  "achieved"
    t.integer  "workstream_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.date     "achieved_at"
  end

  create_table "tasks", force: :cascade do |t|
    t.string   "name"
    t.date     "target"
    t.boolean  "done"
    t.integer  "goal_id"
    t.integer  "successor_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "pwd"
    t.boolean  "isadmin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "workstreams", force: :cascade do |t|
    t.string   "name"
    t.string   "type"
    t.integer  "parent_workstream_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "color"
  end

end
