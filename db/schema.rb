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

ActiveRecord::Schema[7.0].define(version: 2022_08_15_102853) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admissions", force: :cascade do |t|
    t.string "status", default: "Pending"
    t.bigint "user_id", null: false
    t.bigint "league_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["league_id"], name: "index_admissions_on_league_id"
    t.index ["user_id"], name: "index_admissions_on_user_id"
  end

  create_table "bets", force: :cascade do |t|
    t.integer "position"
    t.integer "score"
    t.bigint "user_id", null: false
    t.bigint "boat_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["boat_id"], name: "index_bets_on_boat_id"
    t.index ["user_id"], name: "index_bets_on_user_id"
  end

  create_table "boats", force: :cascade do |t|
    t.string "name"
    t.string "skipper_first_name"
    t.string "skipper_nationality"
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "url_link"
    t.string "skipper_last_name"
  end

  create_table "leagues", force: :cascade do |t|
    t.string "title"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_leagues_on_user_id"
  end

  create_table "registrations", force: :cascade do |t|
    t.string "status", default: "Pending"
    t.bigint "user_id", null: false
    t.bigint "league_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["league_id"], name: "index_registrations_on_league_id"
    t.index ["user_id"], name: "index_registrations_on_user_id"
  end

  create_table "results", force: :cascade do |t|
    t.integer "result_position"
    t.bigint "boat_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["boat_id"], name: "index_results_on_boat_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "admissions", "leagues"
  add_foreign_key "admissions", "users"
  add_foreign_key "bets", "boats"
  add_foreign_key "bets", "users"
  add_foreign_key "leagues", "users"
  add_foreign_key "registrations", "leagues"
  add_foreign_key "registrations", "users"
  add_foreign_key "results", "boats"
end
