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

ActiveRecord::Schema.define(version: 20140909160851) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "allowances", force: true do |t|
    t.integer  "year"
    t.integer  "max_days"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "allowances", ["user_id"], name: "index_allowances_on_user_id", using: :btree

  create_table "roles", force: true do |t|
    t.string   "name",       limit: 32
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  create_table "time_periods", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "start_date"
    t.datetime "end_date"
    t.text     "comment"
    t.integer  "status",     default: 0
    t.integer  "category",   default: 0
    t.integer  "user_id"
  end

  add_index "time_periods", ["user_id"], name: "index_time_periods_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.text     "identifier"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
