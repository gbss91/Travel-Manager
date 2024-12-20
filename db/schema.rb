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

ActiveRecord::Schema[7.1].define(version: 20_221_122_200_349) do # rubocop:disable Metrics/BlockLength
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookings", force: :cascade do |t|
    t.integer "user_id", null: false
    t.date "booked_on_date", null: false
    t.string "origin", null: false
    t.string "destination", null: false
    t.date "departure_date", null: false
    t.date "return_date", null: false
    t.integer "adults", null: false
    t.string "booking_class"
    t.string "status", null: false
    t.float "total_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "booking_type"
    t.text "img_url"
    t.string "origin_city_code", null: false
    t.string "destination_city_code", null: false
    t.index ["destination"], name: "index_bookings_on_destination"
    t.index ["status"], name: "index_bookings_on_status"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "flights", force: :cascade do |t|
    t.string "flight_no", null: false
    t.string "carrier", null: false
    t.string "origin_city", null: false
    t.string "destination_city", null: false
    t.datetime "departure_time", null: false
    t.datetime "arrival_time", null: false
    t.time "duration", null: false
    t.integer "adults", null: false
    t.float "total_price", null: false
    t.bigint "booking_id", null: false
    t.string "carrier_code", null: false
    t.string "direction", null: false
    t.index ["booking_id"], name: "index_flights_on_booking_id"
    t.index ["carrier"], name: "index_flights_on_carrier"
    t.index ["flight_no"], name: "index_flights_on_flight_no"
  end

  create_table "hotels", force: :cascade do |t|
    t.bigint "booking_id", null: false
    t.string "hotel_name", null: false
    t.text "address"
    t.string "city", null: false
    t.date "check_in_date", null: false
    t.integer "no_nights", null: false
    t.float "rate", null: false
    t.float "total_price", null: false
    t.string "room_type"
    t.index ["booking_id"], name: "index_hotels_on_booking_id"
    t.index ["hotel_name"], name: "index_hotels_on_hotel_name"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "last_sign_in_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.boolean "admin", default: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end
end
