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

ActiveRecord::Schema.define(version: 20150330064123) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "months", force: :cascade do |t|
    t.integer  "year_id"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "operations", force: :cascade do |t|
    t.string   "name"
    t.date     "op_date"
    t.text     "ships",                     default: [],              array: true
    t.string   "doctrine"
    t.string   "fleet_commander"
    t.string   "voice_coms_server"
    t.string   "voice_coms_server_channel"
    t.string   "rally_point"
    t.text     "specialty_roles",           default: [],              array: true
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "month_id"
    t.datetime "op_prep_start"
    t.datetime "op_departure"
    t.datetime "op_completion"
  end

  create_table "recruit_contacts", force: :cascade do |t|
    t.string   "name"
    t.string   "contacted_by"
    t.string   "conversation_type"
    t.string   "timezone"
    t.text     "conclusion"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "recruit_contacts", ["name"], name: "index_recruit_contacts_on_name", unique: true, using: :btree

  create_table "recruit_requirements", force: :cascade do |t|
    t.text     "detail"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "hierarchy_ranking"
    t.integer  "user_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  create_table "videos", force: :cascade do |t|
    t.string   "name"
    t.date     "filmed_on"
    t.integer  "operation_id"
    t.string   "s3_url"
    t.string   "kind"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "years", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
