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

ActiveRecord::Schema.define(version: 20151204060005) do

  create_table "abilities", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "abilities_players", force: :cascade do |t|
    t.integer  "ability_id", limit: 4
    t.integer  "player_id",  limit: 4
    t.integer  "time",       limit: 4
    t.integer  "level",      limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "abilities_players", ["ability_id"], name: "index_abilities_players_on_ability_id", using: :btree
  add_index "abilities_players", ["level"], name: "index_abilities_players_on_level", using: :btree
  add_index "abilities_players", ["player_id"], name: "index_abilities_players_on_player_id", using: :btree
  add_index "abilities_players", ["time"], name: "index_abilities_players_on_time", using: :btree

  create_table "heroes", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.string   "localized_name", limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "items", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.integer  "cost",           limit: 4,   default: 0
    t.boolean  "secret_shop",                default: false
    t.boolean  "side_shop",                  default: false
    t.boolean  "recipe",                     default: false
    t.string   "localized_name", limit: 255
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  create_table "items_players", force: :cascade do |t|
    t.integer "item_id",   limit: 4
    t.integer "player_id", limit: 4
  end

  add_index "items_players", ["item_id"], name: "index_items_players_on_item_id", using: :btree
  add_index "items_players", ["player_id"], name: "index_items_players_on_player_id", using: :btree

  create_table "lobbies", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "matches", force: :cascade do |t|
    t.integer  "win",                      limit: 4,   default: 0
    t.integer  "skill",                    limit: 4
    t.integer  "duration",                 limit: 4,   default: 0
    t.datetime "start_time"
    t.integer  "match_seq_num",            limit: 4
    t.integer  "tower_status_radiant",     limit: 4
    t.integer  "tower_status_dire",        limit: 4
    t.integer  "barracks_status_radiant",  limit: 4,   default: 0
    t.integer  "barracks_status_dire",     limit: 4,   default: 0
    t.integer  "cluster",                  limit: 4
    t.integer  "first_blood_time",         limit: 4
    t.integer  "lobby_type",               limit: 4
    t.integer  "human_players",            limit: 4,   default: 0
    t.integer  "leagueid",                 limit: 4
    t.integer  "positive_votes",           limit: 4,   default: 0
    t.integer  "negative_votes",           limit: 4,   default: 0
    t.integer  "game_mode",                limit: 4
    t.integer  "engine",                   limit: 4
    t.datetime "map_picture_updated_at"
    t.integer  "map_picture_file_size",    limit: 4
    t.string   "map_picture_content_type", limit: 255
    t.string   "map_picture_file_name",    limit: 255
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
  end

  add_index "matches", ["game_mode"], name: "index_matches_on_game_mode", using: :btree
  add_index "matches", ["leagueid"], name: "index_matches_on_leagueid", using: :btree
  add_index "matches", ["lobby_type"], name: "index_matches_on_lobby_type", using: :btree
  add_index "matches", ["match_seq_num"], name: "index_matches_on_match_seq_num", using: :btree

  create_table "modes", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "players", force: :cascade do |t|
    t.string   "account_id",    limit: 255
    t.integer  "player_slot",   limit: 4
    t.integer  "hero_id",       limit: 4
    t.integer  "kills",         limit: 4,   default: 0
    t.integer  "deaths",        limit: 4,   default: 0
    t.integer  "assists",       limit: 4,   default: 0
    t.integer  "leaver_status", limit: 4
    t.integer  "gold",          limit: 4,   default: 0
    t.integer  "last_hits",     limit: 4,   default: 0
    t.integer  "denies",        limit: 4,   default: 0
    t.integer  "gold_per_min",  limit: 4,   default: 0
    t.integer  "xp_per_min",    limit: 4,   default: 0
    t.integer  "gold_spent",    limit: 4,   default: 0
    t.integer  "hero_damage",   limit: 4,   default: 0
    t.integer  "tower_damage",  limit: 4,   default: 0
    t.integer  "hero_healing",  limit: 4,   default: 0
    t.integer  "level",         limit: 4,   default: 0
    t.integer  "match_id",      limit: 4
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "players", ["account_id"], name: "index_players_on_account_id", using: :btree
  add_index "players", ["hero_id"], name: "index_players_on_hero_id", using: :btree

  create_table "regions", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "nickname",              limit: 255
    t.string   "name",                  limit: 255
    t.string   "image_url",             limit: 255
    t.string   "profile_url",           limit: 255
    t.string   "account_id",            limit: 255
    t.integer  "last_updated_match_id", limit: 4
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",         limit: 4,   default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",    limit: 255
    t.string   "last_sign_in_ip",       limit: 255
    t.string   "provider",              limit: 255
    t.string   "uid",                   limit: 255
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  add_index "users", ["account_id"], name: "index_users_on_account_id", using: :btree
  add_index "users", ["name"], name: "index_users_on_name", using: :btree
  add_index "users", ["nickname"], name: "index_users_on_nickname", using: :btree
  add_index "users", ["provider"], name: "index_users_on_provider", using: :btree
  add_index "users", ["uid"], name: "index_users_on_uid", using: :btree

end
