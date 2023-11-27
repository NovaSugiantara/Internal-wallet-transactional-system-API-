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

ActiveRecord::Schema[7.1].define(version: 2023_11_27_085055) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "credits", force: :cascade do |t|
    t.decimal "amount"
    t.bigint "wallet_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "wallet_type"
    t.index ["wallet_id"], name: "index_credits_on_wallet_id"
  end

  create_table "debits", force: :cascade do |t|
    t.decimal "amount"
    t.bigint "wallet_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "wallet_type"
    t.index ["wallet_id"], name: "index_debits_on_wallet_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wallets", force: :cascade do |t|
    t.decimal "balance", default: "0.0"
    t.string "source_wallet_type"
    t.bigint "source_wallet_id"
    t.string "target_wallet_type"
    t.bigint "target_wallet_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "entity_type", null: false
    t.bigint "entity_id", null: false
    t.string "wallet_type"
    t.index ["entity_type", "entity_id"], name: "index_wallets_on_entity"
    t.index ["source_wallet_type", "source_wallet_id"], name: "index_wallets_on_source_wallet"
    t.index ["target_wallet_type", "target_wallet_id"], name: "index_wallets_on_target_wallet"
  end

  add_foreign_key "credits", "wallets"
  add_foreign_key "debits", "wallets"
  add_foreign_key "sessions", "users"
end
