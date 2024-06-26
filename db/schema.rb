# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_04_16_102308) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "item_sales", force: :cascade do |t|
    t.bigint "item_id", null: false
    t.bigint "sale_id", null: false
    t.integer "quantity"
    t.integer "discount_val"
    t.integer "discount_unit"
    t.integer "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_item_sales_on_item_id"
    t.index ["sale_id"], name: "index_item_sales_on_sale_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "storage_id", null: false
    t.string "image"
    t.integer "quantity", null: false
    t.integer "unit", null: false
    t.string "description"
    t.integer "cost_price"
    t.integer "sell_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["storage_id"], name: "index_items_on_storage_id"
  end

  create_table "sales", force: :cascade do |t|
    t.date "transaction_date"
    t.text "note"
    t.integer "shipping_charge"
    t.integer "total_amount"
    t.bigint "storage_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["storage_id"], name: "index_sales_on_storage_id"
  end

  create_table "storages", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_storages", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "storage_id", null: false
    t.integer "role"
    t.index ["storage_id"], name: "index_users_storages_on_storage_id"
    t.index ["user_id"], name: "index_users_storages_on_user_id"
  end

  add_foreign_key "item_sales", "items"
  add_foreign_key "item_sales", "sales"
  add_foreign_key "items", "storages"
  add_foreign_key "sales", "storages"
  add_foreign_key "users_storages", "storages"
  add_foreign_key "users_storages", "users"
end
