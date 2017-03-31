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

ActiveRecord::Schema.define(version: 20170331112421) do

  create_table "action_controller_loggers", force: :cascade do |t|
    t.string   "log_unique_id",      limit: 255
    t.integer  "user_id",            limit: 4
    t.string   "session_id",         limit: 255
    t.string   "request_user_agent", limit: 255
    t.text     "request_headers",    limit: 65535
    t.text     "request_from_page",  limit: 65535
    t.string   "controller",         limit: 255
    t.string   "action",             limit: 255
    t.integer  "status",             limit: 2,          default: 0
    t.string   "remote_ip",          limit: 255
    t.text     "process",            limit: 4294967295
    t.datetime "start_time"
    t.float    "view_runtime",       limit: 24
    t.float    "db_runtime",         limit: 24
    t.float    "duration",           limit: 24
  end

  add_index "action_controller_loggers", ["log_unique_id", "user_id", "session_id"], name: "action_controller_loggers", using: :btree

  create_table "action_view_loggers", force: :cascade do |t|
    t.string   "log_unique_id", limit: 255
    t.text     "process",       limit: 4294967295
    t.datetime "start_time"
    t.float    "duration",      limit: 24
  end

  add_index "action_view_loggers", ["log_unique_id"], name: "index_action_view_loggers_on_log_unique_id", using: :btree

  create_table "apartments", force: :cascade do |t|
    t.integer  "user_id",     limit: 4,                                            null: false
    t.text     "description", limit: 65535
    t.string   "currency",    limit: 255
    t.decimal  "price",                     precision: 12, scale: 3, default: 0.0
    t.datetime "created_at",                                                       null: false
    t.datetime "updated_at",                                                       null: false
  end

  add_index "apartments", ["user_id"], name: "index_apartments_on_user_id", using: :btree

  create_table "body_response_loggers", force: :cascade do |t|
    t.string "log_unique_id", limit: 255
    t.text   "body_response", limit: 4294967295
  end

  add_index "body_response_loggers", ["log_unique_id"], name: "body_response_loggers_log_unique_id", using: :btree

  create_table "json_controller_action_reports", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "prefix",     limit: 255
    t.string   "postfix",    limit: 255
    t.string   "controller", limit: 255
    t.string   "action",     limit: 255
    t.text     "report",     limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "json_logstashs", force: :cascade do |t|
    t.string   "log_unique_id", limit: 255
    t.string   "severity",      limit: 255
    t.text     "process",       limit: 4294967295
    t.datetime "start_time"
  end

  add_index "json_logstashs", ["log_unique_id"], name: "index_json_logstashs_on_log_unique_id", using: :btree

  create_table "product_reviews", force: :cascade do |t|
    t.integer  "product_id",   limit: 4,                  null: false
    t.text     "message",      limit: 65535,              null: false
    t.string   "hash_message", limit: 64,    default: "", null: false
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  add_index "product_reviews", ["hash_message"], name: "product_reviews_hash_message", unique: true, using: :btree
  add_index "product_reviews", ["product_id"], name: "product_reviews_product_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "name",       limit: 255,                          default: ""
    t.decimal  "price",                  precision: 15, scale: 3
    t.string   "hash_name",  limit: 64,                           default: "", null: false
    t.string   "url",        limit: 255
    t.string   "hash_url",   limit: 64,                           default: "", null: false
    t.integer  "status",     limit: 1,                            default: 0
    t.datetime "created_at",                                                   null: false
    t.datetime "updated_at",                                                   null: false
  end

  add_index "products", ["hash_name"], name: "products_hash_name", using: :btree
  add_index "products", ["hash_url"], name: "products_hash_url", unique: true, using: :btree
  add_index "products", ["status"], name: "products_status", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "provider",               limit: 255
    t.string   "uid",                    limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
