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

ActiveRecord::Schema.define(version: 20150703022032) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "oats", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "toastr_reports", force: :cascade do |t|
    t.string   "type",       null: false
    t.text     "key",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "toastr_reports", ["type", "key"], name: "toastr_reports_type_key", unique: true, using: :btree

  create_table "toastr_toasts", force: :cascade do |t|
    t.integer  "parent_id",   null: false
    t.string   "parent_type", null: false
    t.string   "category",    null: false
    t.jsonb    "cache_json"
    t.text     "status",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "toastr_toasts", ["parent_id", "parent_type", "category"], name: "toasts_parent_category", unique: true, using: :btree
  add_index "toastr_toasts", ["parent_type", "parent_id"], name: "index_toastr_toasts_on_parent_type_and_parent_id", using: :btree

end
