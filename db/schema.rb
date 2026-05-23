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

ActiveRecord::Schema[8.0].define(version: 2026_05_23_073951) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "bills", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "expense_item_participants", force: :cascade do |t|
    t.bigint "expense_item_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "amount_owed"
    t.boolean "paid"
    t.index ["expense_item_id"], name: "index_expense_item_participants_on_expense_item_id"
    t.index ["user_id"], name: "index_expense_item_participants_on_user_id"
  end

  create_table "expense_items", force: :cascade do |t|
    t.bigint "expense_id", null: false
    t.string "title"
    t.decimal "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["expense_id"], name: "index_expense_items_on_expense_id"
  end

  create_table "expense_participants", force: :cascade do |t|
    t.bigint "expense_id", null: false
    t.bigint "user_id", null: false
    t.decimal "amount_owed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["expense_id"], name: "index_expense_participants_on_expense_id"
    t.index ["user_id"], name: "index_expense_participants_on_user_id"
  end

  create_table "expenses", force: :cascade do |t|
    t.string "title"
    t.decimal "amount"
    t.bigint "paid_by_id"
    t.bigint "created_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_expenses_on_created_by_id"
    t.index ["paid_by_id"], name: "index_expenses_on_paid_by_id"
  end

  create_table "settlements", force: :cascade do |t|
    t.bigint "from_user_id"
    t.bigint "to_user_id"
    t.decimal "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["from_user_id"], name: "index_settlements_on_from_user_id"
    t.index ["to_user_id"], name: "index_settlements_on_to_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "expense_item_participants", "expense_items"
  add_foreign_key "expense_item_participants", "users"
  add_foreign_key "expense_items", "expenses"
  add_foreign_key "expense_participants", "expenses"
  add_foreign_key "expense_participants", "users"
  add_foreign_key "expenses", "users", column: "created_by_id"
  add_foreign_key "expenses", "users", column: "paid_by_id"
  add_foreign_key "settlements", "users", column: "from_user_id"
  add_foreign_key "settlements", "users", column: "to_user_id"
end
