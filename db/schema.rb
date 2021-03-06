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

ActiveRecord::Schema.define(version: 20151026132719) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "album_artists", force: :cascade do |t|
    t.integer  "artist_id"
    t.integer  "album_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "albums", force: :cascade do |t|
    t.string   "image_url"
    t.string   "name"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "spotify_album_id"
  end

  create_table "artist_tracks", force: :cascade do |t|
    t.integer  "artist_id"
    t.integer  "track_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "artists", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "spotify_artist_id"
  end

  create_table "fuzzies", force: :cascade do |t|
    t.integer "track_id"
    t.float   "match"
    t.integer "match_id"
  end

  create_table "playlist_tracks", force: :cascade do |t|
    t.integer  "track_id"
    t.integer  "playlist_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "positions"
    t.integer  "copies",         default: 0
    t.integer  "position_count"
  end

  create_table "playlists", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "spotify_playlist_id"
    t.string   "snap_shot_id"
  end

  create_table "tracks", force: :cascade do |t|
    t.integer  "album_id"
    t.string   "name"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "spotify_track_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "spotify_user_id"
    t.string   "spotify_auth_token"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "username"
  end

end
