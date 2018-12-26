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

ActiveRecord::Schema.define(version: 2018_12_26_231817) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accountants", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.index ["email"], name: "index_accountants_on_email", unique: true
    t.index ["reset_password_token"], name: "index_accountants_on_reset_password_token", unique: true
  end

  create_table "accounts", force: :cascade do |t|
    t.string "name"
    t.bigint "accountant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["accountant_id"], name: "index_accounts_on_accountant_id"
  end

  create_table "families", force: :cascade do |t|
    t.string "name"
    t.bigint "accountant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["accountant_id"], name: "index_families_on_accountant_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.bigint "accountant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["accountant_id"], name: "index_items_on_accountant_id"
  end

  create_table "subitems", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "level"
    t.string "account_type"
    t.bigint "item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_subitems_on_item_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.datetime "date_transaction"
    t.decimal "value"
    t.string "description"
    t.string "title"
    t.decimal "amount"
    t.bigint "subitem_id"
    t.bigint "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_transactions_on_account_id"
    t.index ["subitem_id"], name: "index_transactions_on_subitem_id"
  end

  create_table "transfers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "origin_transaction_id"
    t.bigint "destiny_transaction_id"
    t.index ["destiny_transaction_id"], name: "index_transfers_on_destiny_transaction_id"
    t.index ["origin_transaction_id"], name: "index_transfers_on_origin_transaction_id"
  end

  add_foreign_key "families", "accountants"
  add_foreign_key "transfers", "transactions", column: "destiny_transaction_id"
  add_foreign_key "transfers", "transactions", column: "origin_transaction_id"
end
