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

ActiveRecord::Schema.define(version: 20160125152748) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendances", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.integer  "event_id"
  end

  create_table "bands", force: :cascade do |t|
    t.string   "name"
    t.integer  "establish_year"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "genre_id"
    t.string   "cover_photo_file_name"
    t.string   "cover_photo_content_type"
    t.integer  "cover_photo_file_size"
    t.datetime "cover_photo_updated_at"
  end

  create_table "events", force: :cascade do |t|
    t.datetime "start_time"
    t.integer  "duration"
    t.string   "place"
    t.string   "info"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "band_id"
    t.string   "title"
  end

  create_table "genres", force: :cascade do |t|
    t.string "name"
  end

  create_table "opinions", force: :cascade do |t|
    t.text     "text"
    t.integer  "user_id"
    t.integer  "band_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "opinions", ["band_id"], name: "index_opinions_on_band_id", using: :btree
  add_index "opinions", ["user_id"], name: "index_opinions_on_user_id", using: :btree

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.text     "text"
    t.integer  "band_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "posts", ["band_id"], name: "index_posts_on_band_id", using: :btree

  create_table "reactions", force: :cascade do |t|
    t.boolean  "positive"
    t.integer  "user_id"
    t.integer  "opinion_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "reactions", ["opinion_id"], name: "index_reactions_on_opinion_id", using: :btree
  add_index "reactions", ["user_id"], name: "index_reactions_on_user_id", using: :btree

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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "username"
    t.date     "dob"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "band_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
