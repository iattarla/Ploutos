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

ActiveRecord::Schema.define(version: 20160318212710) do

  create_table "categories", force: :cascade do |t|
    t.string   "name",          limit: 255,  null: false
    t.integer  "parent_id",     limit: 4
    t.integer  "sort_order",    limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "custom_fields", limit: 4096
  end

  create_table "category_hierarchies", id: false, force: :cascade do |t|
    t.integer "ancestor_id",   limit: 4, null: false
    t.integer "descendant_id", limit: 4, null: false
    t.integer "generations",   limit: 4, null: false
  end

  add_index "category_hierarchies", ["ancestor_id", "descendant_id", "generations"], name: "category_anc_desc_idx", unique: true, using: :btree
  add_index "category_hierarchies", ["descendant_id"], name: "category_desc_idx", using: :btree

  create_table "items", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.text     "description",   limit: 65535
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "category_id",   limit: 4
    t.string   "brand",         limit: 255
    t.string   "model",         limit: 255
    t.integer  "unit_id",       limit: 4
    t.integer  "quantity",      limit: 4
    t.decimal  "price",                       precision: 10
    t.datetime "delivery_date"
    t.string   "kind",          limit: 1
    t.string   "owner",         limit: 255
  end

  add_index "items", ["category_id"], name: "index_items_on_category_id", using: :btree
  add_index "items", ["unit_id"], name: "index_items_on_unit_id", using: :btree

  create_table "location_hierarchies", id: false, force: :cascade do |t|
    t.integer "ancestor_id",   limit: 4, null: false
    t.integer "descendant_id", limit: 4, null: false
    t.integer "generations",   limit: 4, null: false
  end

  add_index "location_hierarchies", ["ancestor_id", "descendant_id", "generations"], name: "location_anc_desc_idx", unique: true, using: :btree
  add_index "location_hierarchies", ["descendant_id"], name: "location_desc_idx", using: :btree

  create_table "locations", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "code",       limit: 255
    t.integer  "parent_id",  limit: 4
    t.integer  "sort_order", limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "pieces", force: :cascade do |t|
    t.datetime "guarantee_start"
    t.datetime "guarantee_expiry"
    t.text     "notes",            limit: 65535
    t.boolean  "status",                         default: true
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.integer  "item_id",          limit: 4
    t.integer  "user_id",          limit: 4
    t.integer  "location_id",      limit: 4
    t.datetime "delivery_date"
    t.string   "serial_no",        limit: 255
    t.integer  "quantity",         limit: 4
  end

  add_index "pieces", ["item_id"], name: "index_pieces_on_item_id", using: :btree
  add_index "pieces", ["location_id"], name: "index_pieces_on_location_id", using: :btree
  add_index "pieces", ["user_id"], name: "index_pieces_on_user_id", using: :btree

  create_table "pieces_reports", id: false, force: :cascade do |t|
    t.integer "report_id", limit: 4
    t.integer "piece_id",  limit: 4
    t.text    "note",      limit: 65535
    t.boolean "status"
  end

  add_index "pieces_reports", ["piece_id"], name: "index_pieces_reports_on_piece_id", using: :btree
  add_index "pieces_reports", ["report_id"], name: "index_pieces_reports_on_report_id", using: :btree

  create_table "reports", force: :cascade do |t|
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "user_id",    limit: 4
    t.boolean  "submitted",            default: false
  end

  add_index "reports", ["user_id"], name: "index_reports_on_user_id", using: :btree

  create_table "units", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "abbr",       limit: 255
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.integer  "failed_attempts",        limit: 4,   default: 0,     null: false
    t.string   "unlock_token",           limit: 255
    t.datetime "locked_at"
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.boolean  "admin",                              default: false
    t.boolean  "moderator",                          default: false
    t.string   "username",               limit: 255
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
