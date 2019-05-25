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

ActiveRecord::Schema.define(version: 2019_05_25_131024) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accountants", force: :cascade do |t|
    t.string "name"
    t.bigint "family_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.boolean "owner", default: false
    t.string "profile"
    t.index ["email"], name: "index_accountants_on_email", unique: true
    t.index ["family_id"], name: "index_accountants_on_family_id"
    t.index ["reset_password_token"], name: "index_accountants_on_reset_password_token", unique: true
  end

  create_table "accounts", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.bigint "accountant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "header_file"
    t.index ["accountant_id"], name: "index_accounts_on_accountant_id"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "bank_statements", force: :cascade do |t|
    t.bigint "accountant_id"
    t.bigint "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "pay_date"
    t.index ["account_id"], name: "index_bank_statements_on_account_id"
    t.index ["accountant_id"], name: "index_bank_statements_on_accountant_id"
  end

  create_table "closed_months", force: :cascade do |t|
    t.integer "price_cents"
    t.bigint "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "reference", null: false
    t.index ["account_id"], name: "index_closed_months_on_account_id"
  end

  create_table "families", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.bigint "accountant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["accountant_id"], name: "index_items_on_accountant_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.bigint "accountant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["accountant_id"], name: "index_roles_on_accountant_id"
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

  create_table "tasks", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.boolean "done", default: false
    t.date "due_date"
    t.string "task_type"
    t.bigint "accountant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["accountant_id"], name: "index_tasks_on_accountant_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.date "date_transaction"
    t.string "description"
    t.string "title"
    t.decimal "amount"
    t.bigint "subitem_id"
    t.bigint "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "origin"
    t.integer "price_cents"
    t.string "input"
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

  add_foreign_key "accountants", "families"
  add_foreign_key "bank_statements", "accountants"
  add_foreign_key "bank_statements", "accounts"
  add_foreign_key "roles", "accountants"
  add_foreign_key "tasks", "accountants"
  add_foreign_key "transfers", "transactions", column: "destiny_transaction_id"
  add_foreign_key "transfers", "transactions", column: "origin_transaction_id"
end
