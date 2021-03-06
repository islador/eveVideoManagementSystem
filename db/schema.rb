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

ActiveRecord::Schema.define(version: 20150421234917) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chrRaces", primary_key: "raceID", force: :cascade do |t|
    t.text    "raceName"
    t.text    "description"
    t.integer "iconID",           limit: 8
    t.text    "shortDescription"
  end

  create_table "doctrines", force: :cascade do |t|
    t.string   "name"
    t.string   "short_description"
    t.text     "long_description"
    t.boolean  "access_by_hierarchy"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "abbreviation"
  end

  create_table "doctrines_roles", force: :cascade do |t|
    t.integer  "role_id"
    t.integer  "doctrine_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "fac_war_systems", force: :cascade do |t|
    t.integer  "solarSystemID"
    t.string   "solarSystemName"
    t.integer  "occupyingFactionID"
    t.integer  "owningFactionID"
    t.string   "occupyingFactionName"
    t.string   "owningFactionName"
    t.boolean  "contested"
    t.integer  "victoryPoints"
    t.integer  "victoryPointThreshold"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "fittings", force: :cascade do |t|
    t.string   "name"
    t.string   "hull"
    t.string   "race"
    t.string   "fleet_role"
    t.text     "description"
    t.string   "progression"
    t.integer  "progression_position"
    t.string   "eft_string"
    t.string   "ship_dna"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "doctrine_id"
  end

  create_table "invTypes", primary_key: "typeID", force: :cascade do |t|
    t.integer  "groupID",             limit: 8
    t.text     "typeName"
    t.text     "description"
    t.decimal  "mass",                          precision: 64, scale: 12
    t.decimal  "volume",                        precision: 64, scale: 12
    t.decimal  "capacity",                      precision: 64, scale: 12
    t.integer  "portionSize",         limit: 8
    t.decimal  "basePrice",                     precision: 19, scale: 4
    t.boolean  "published"
    t.integer  "marketGroupID",       limit: 8
    t.integer  "chanceofDuplicating", limit: 8
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
  end

  add_index "invTypes", ["groupID"], name: "idx_149637_invTypes_IX_Group", using: :btree

  create_table "doctrines_roles", force: :cascade do |t|
    t.integer  "role_id"
    t.integer  "doctrine_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "members", force: :cascade do |t|
    t.integer  "characterID"
    t.string   "name"
    t.datetime "startDateTime"
    t.integer  "baseID"
    t.string   "base"
    t.string   "title"
    t.datetime "logonDateTime"
    t.datetime "logoffDateTime"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.boolean  "taken"
    t.integer  "user_id"
  end

  create_table "members_roles", force: :cascade do |t|
    t.integer  "member_id"
    t.integer  "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "members_roles", ["member_id"], name: "index_members_roles_on_member_id", using: :btree
  add_index "members_roles", ["role_id"], name: "index_members_roles_on_role_id", using: :btree

  create_table "mission_groups", force: :cascade do |t|
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "name"
    t.integer  "user_id"
    t.text     "participants", default: [],              array: true
  end

  create_table "missions", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "fac_war_system_id"
    t.integer  "loyalty_points"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.text     "mission_text",      default: [],              array: true
    t.integer  "mission_group_id"
    t.boolean  "incomplete"
    t.boolean  "complete"
    t.boolean  "obstructed"
  end

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
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "roles_members", force: :cascade do |t|
    t.integer  "role_id"
    t.integer  "member_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles_users", force: :cascade do |t|
    t.integer  "role_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "roles_users", ["role_id"], name: "index_roles_users_on_role_id", using: :btree
  add_index "roles_users", ["user_id"], name: "index_roles_users_on_user_id", using: :btree

  create_table "solar_systems", force: :cascade do |t|
    t.string   "solarSystemName"
    t.integer  "solarSystemID"
    t.float    "security"
    t.string   "missions"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "users", force: :cascade do |t|
    t.integer  "sign_in_count",       default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
    t.string   "main_character_name"
    t.integer  "main_character_id"
  end

  create_table "videos", force: :cascade do |t|
    t.string   "name"
    t.date     "filmed_on"
    t.integer  "operation_id"
    t.string   "s3_url"
    t.string   "kind"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "warCombatZoneSystems", primary_key: "solarSystemID", force: :cascade do |t|
    t.integer  "combatZoneID", limit: 8
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "years", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
