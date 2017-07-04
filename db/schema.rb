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

  create_table "channels", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.integer "quantity"
    t.index ["name"], name: "index_channels_on_name"
    t.index ["quantity"], name: "index_channels_on_quantity"
  end

  create_table "irc_posts", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "track_id"
    t.integer "channel_id"
    t.integer "user_id"
    t.datetime "posted_at"
    t.index ["channel_id"], name: "index_irc_posts_on_channel_id"
    t.index ["track_id"], name: "index_irc_posts_on_track_id"
    t.index ["user_id"], name: "index_irc_posts_on_user_id"
  end

  create_table "tag_assignations", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "track_id", null: false
    t.bigint "tag_id", null: false
    t.index ["tag_id"], name: "index_tag_assignations_on_tag_id"
    t.index ["track_id"], name: "index_tag_assignations_on_track_id"
  end

  create_table "tags", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.integer "quantity"
    t.index ["name"], name: "index_tags_on_name"
    t.index ["quantity"], name: "index_tags_on_quantity"
  end

  create_table "tracks", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "url"
    t.string "provider"
    t.string "author"
    t.string "channel"
    t.index ["channel"], name: "index_tracks_on_channel"
    t.index ["name"], name: "index_tracks_on_name"
  end

  create_table "users", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.integer "quantity"
    t.index ["name"], name: "index_users_on_name"
    t.index ["quantity"], name: "index_users_on_quantity"
  end

end
