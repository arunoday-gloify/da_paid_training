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

ActiveRecord::Schema[8.1].define(version: 2026_06_26_145000) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "customers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index "lower((email)::text)", name: "index_customers_on_lower_email", unique: true
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "attempts", default: 0, null: false
    t.datetime "created_at"
    t.datetime "failed_at"
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "locked_at"
    t.string "locked_by"
    t.integer "priority", default: 0, null: false
    t.string "queue"
    t.datetime "run_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "order_items", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "order_id", null: false
    t.bigint "product_id", null: false
    t.integer "quantity", default: 1, null: false
    t.integer "unit_price_cents", default: 0, null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["product_id"], name: "index_order_items_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "customer_id", null: false
    t.string "status", default: "pending", null: false
    t.integer "total_cents", default: 0, null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_orders_on_customer_id"
    t.index ["status"], name: "index_orders_on_status"
  end

  create_table "products", force: :cascade do |t|
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.text "description"
    t.string "name", null: false
    t.integer "price_cents", default: 0, null: false
    t.string "sku", null: false
    t.datetime "updated_at", null: false
    t.index "lower((sku)::text)", name: "index_products_on_lower_sku", unique: true
    t.index ["active"], name: "index_products_on_active"
  end

  create_table "sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "expires_at", null: false
    t.string "ip_address"
    t.datetime "last_used_at"
    t.string "refresh_jti", null: false
    t.datetime "revoked_at"
    t.datetime "updated_at", null: false
    t.string "user_agent"
    t.bigint "user_id", null: false
    t.index ["expires_at"], name: "index_sessions_on_expires_at"
    t.index ["refresh_jti"], name: "index_sessions_on_refresh_jti", unique: true
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "password_digest", null: false
    t.string "role", default: "member", null: false
    t.datetime "updated_at", null: false
    t.string "username", null: false
    t.index "lower((username)::text)", name: "index_users_on_lower_username", unique: true
    t.index ["role"], name: "index_users_on_role"
  end

  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "products"
  add_foreign_key "orders", "customers"
  add_foreign_key "sessions", "users"
end
