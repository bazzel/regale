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

ActiveRecord::Schema.define(version: 2018_11_19_105354) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dishes", force: :cascade do |t|
    t.string "title", limit: 100
    t.string "description", limit: 255
    t.bigint "event_id"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_dishes_on_event_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "title", limit: 100
    t.datetime "scheduled_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "guests_count", default: 0
    t.datetime "respond_before"
  end

  create_table "guests", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "accept_status"
    t.bigint "soup_id"
    t.bigint "appetizer_id"
    t.bigint "main_course_id"
    t.bigint "dessert_id"
    t.index ["appetizer_id"], name: "index_guests_on_appetizer_id"
    t.index ["dessert_id"], name: "index_guests_on_dessert_id"
    t.index ["event_id"], name: "index_guests_on_event_id"
    t.index ["main_course_id"], name: "index_guests_on_main_course_id"
    t.index ["soup_id"], name: "index_guests_on_soup_id"
    t.index ["user_id"], name: "index_guests_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", limit: 255
    t.string "name", limit: 100
    t.string "login_token"
    t.datetime "login_token_valid_until"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "guests", "dishes", column: "appetizer_id"
  add_foreign_key "guests", "dishes", column: "dessert_id"
  add_foreign_key "guests", "dishes", column: "main_course_id"
  add_foreign_key "guests", "dishes", column: "soup_id"
  add_foreign_key "guests", "events"
  add_foreign_key "guests", "users"
end
