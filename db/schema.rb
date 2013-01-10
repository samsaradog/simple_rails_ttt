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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130110143722) do

  create_table "activation_records", :force => true do |t|
    t.boolean  "active",     :default => false
    t.string   "token"
    t.integer  "player_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "activation_records", ["token"], :name => "index_activation_records_on_token"

  create_table "game_states", :force => true do |t|
    t.string   "token"
    t.string   "player"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "matches", :force => true do |t|
    t.integer  "cipher"
    t.integer  "player_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "matches", ["cipher"], :name => "index_matches_on_cipher"

  create_table "players", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "bio"
    t.string   "password_digest"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "remember_token"
  end

  add_index "players", ["email"], :name => "index_players_on_email", :unique => true
  add_index "players", ["remember_token"], :name => "index_players_on_remember_token"

  create_table "scorecards", :force => true do |t|
    t.integer  "player_id"
    t.integer  "games_won"
    t.integer  "games_lost"
    t.integer  "draw_games"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "scorecards", ["player_id"], :name => "index_scorecards_on_player_id"

end
