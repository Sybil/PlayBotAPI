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

ActiveRecord::Schema.define(version: 20150123211134) do

  create_table "channels", force: true do |t|
    t.text    "name"
    t.integer "quantity"
  end

  create_table "dj", force: true do |t|
    t.string  "nom_complet", null: false
    t.string  "nom_aff",     null: false
    t.string  "photo",       null: false
    t.string  "style",       null: false
    t.integer "promo",       null: false
    t.text    "materiel",    null: false
    t.text    "musiques",    null: false
  end

  create_table "irc_posts", force: true do |t|
    t.integer  "track_id"
    t.integer  "channel_id"
    t.integer  "user_id"
    t.datetime "posted_at"
  end

  create_table "news", force: true do |t|
    t.string  "titre",  null: false
    t.string  "auteur", null: false
    t.integer "date",   null: false
    t.text    "texte",  null: false
  end

  create_table "playbot", force: true do |t|
    t.date    "date"
    t.string  "type",       limit: 15,                  null: false
    t.string  "url",                                    null: false
    t.string  "sender_irc", limit: 99
    t.string  "sender"
    t.string  "title",                                  null: false
    t.integer "duration",               default: 0,     null: false
    t.string  "file",       limit: 150
    t.boolean "broken",                 default: false, null: false
    t.string  "channel",                                null: false
  end

  add_index "playbot", ["channel"], name: "chan", using: :btree
  add_index "playbot", ["url"], name: "url", unique: true, using: :btree

  create_table "playbot_chan", force: true do |t|
    t.timestamp "date"
    t.string    "sender_irc", limit: 99, null: false
    t.integer   "content",               null: false
    t.string    "chan",                  null: false
  end

  add_index "playbot_chan", ["content"], name: "content", using: :btree

  create_table "playbot_codes", primary_key: "user", force: true do |t|
    t.string "code", limit: 25, null: false
    t.string "nick"
  end

  add_index "playbot_codes", ["code"], name: "code", unique: true, using: :btree
  add_index "playbot_codes", ["nick"], name: "nick", unique: true, using: :btree

  create_table "playbot_fav", id: false, force: true do |t|
    t.string  "user", null: false
    t.integer "id",   null: false
  end

  add_index "playbot_fav", ["id"], name: "id", using: :btree
  add_index "playbot_fav", ["user"], name: "user", using: :btree

  create_table "playbot_later", force: true do |t|
    t.integer "content", null: false
    t.string  "nick",    null: false
    t.integer "date",    null: false
  end

  add_index "playbot_later", ["content"], name: "content", using: :btree

  create_table "playbot_tags", id: false, force: true do |t|
    t.integer "id",             null: false
    t.string  "tag", limit: 50, null: false
  end

  add_index "playbot_tags", ["id"], name: "id", using: :btree
  add_index "playbot_tags", ["tag"], name: "tag", using: :btree

  create_table "result_sondages", force: true do |t|
    t.string  "id_sondage", null: false
    t.string  "nom",        null: false
    t.integer "choix1"
    t.integer "choix2"
    t.integer "choix3"
    t.integer "choix4"
  end

  create_table "sam", force: true do |t|
    t.string  "title",                    null: false
    t.integer "date",                     null: false
    t.string  "place"
    t.string  "description", limit: 500
    t.string  "link",        limit: 1000
  end

  create_table "sam_users", force: true do |t|
    t.string  "nick",  limit: 50, null: false
    t.integer "event",            null: false
  end

  add_index "sam_users", ["event"], name: "event_ind", using: :btree
  add_index "sam_users", ["nick", "event"], name: "nick", unique: true, using: :btree

  create_table "sondages", force: true do |t|
    t.string  "intitule", null: false
    t.boolean "affiche"
    t.integer "date",     null: false
    t.string  "choix1",   null: false
    t.string  "choix2",   null: false
    t.string  "choix3"
    t.string  "choix4"
  end

  create_table "songs", force: true do |t|
    t.string "artist",          limit: 100, null: false
    t.string "title",           limit: 100, null: false
    t.string "format_name",     limit: 25,  null: false
    t.string "encoder_version", limit: 25,  null: false
    t.string "sample_rate",     limit: 25,  null: false
    t.string "playing_time",    limit: 25,  null: false
    t.string "file_name",       limit: 100, null: false
  end

  create_table "tag_assignations", id: false, force: true do |t|
    t.integer "track_id", null: false
    t.integer "tag_id",   null: false
  end

  create_table "tags", force: true do |t|
    t.text    "name"
    t.integer "quantity"
  end

  create_table "tracks", force: true do |t|
    t.text "name"
    t.text "url"
    t.text "provider"
    t.text "author"
    t.text "channel"
  end

  create_table "users", force: true do |t|
    t.text    "name"
    t.integer "quantity"
  end

end
