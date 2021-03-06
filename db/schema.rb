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

ActiveRecord::Schema.define(version: 20171230150601) do

  create_table "actions", force: :cascade do |t|
    t.integer  "action_id"
    t.string   "chamber"
    t.string   "action_type"
    t.string   "date"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "bills", force: :cascade do |t|
    t.string   "bill_id"
    t.string   "title"
    t.text     "summary"
    t.string   "date"
    t.string   "sponsor"
    t.string   "sponsor_state"
    t.string   "sponsor_party"
    t.string   "link"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "user_id"
    t.boolean  "status"
  end

  add_index "bills", ["user_id"], name: "index_bills_on_user_id"

  create_table "favorites", force: :cascade do |t|
    t.string   "bill_id"
    t.string   "title"
    t.text     "summary"
    t.string   "date"
    t.string   "sponsor"
    t.string   "sponsor_state"
    t.string   "sponsor_party"
    t.string   "link"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.boolean  "status"
  end

  add_index "favorites", ["user_id"], name: "index_favorites_on_user_id"

  create_table "searches", force: :cascade do |t|
    t.text     "metadata"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "searches", ["user_id"], name: "index_searches_on_user_id"

  create_table "subject_searches", force: :cascade do |t|
    t.string   "metadata"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  add_index "subject_searches", ["user_id"], name: "index_subject_searches_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "sort"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "votes", force: :cascade do |t|
    t.string   "chamber"
    t.string   "date"
    t.string   "time"
    t.string   "roll_call"
    t.string   "question"
    t.string   "result"
    t.integer  "yea"
    t.integer  "nay"
    t.integer  "not_voting"
    t.string   "api_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
