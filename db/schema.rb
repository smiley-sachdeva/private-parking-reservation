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

ActiveRecord::Schema[7.1].define(version: 2024_05_06_100617) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "features", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "parking_id"
    t.index ["name", "parking_id"], name: "index_features_on_name_and_parking_id", unique: true
    t.index ["parking_id"], name: "index_features_on_parking_id"
  end

  create_table "features_slots", force: :cascade do |t|
    t.bigint "slot_id"
    t.bigint "feature_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["feature_id"], name: "index_features_slots_on_feature_id"
    t.index ["slot_id"], name: "index_features_slots_on_slot_id"
  end

  create_table "jwt_denylists", force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "exp", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["jti"], name: "index_jwt_denylists_on_jti"
  end

  create_table "parking_logs", force: :cascade do |t|
    t.datetime "checkin_time"
    t.datetime "checkout_time"
    t.float "duration"
    t.float "price"
    t.string "plate_number"
    t.integer "reservation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "slot_id"
    t.string "ref_token"
  end

  create_table "parkings", force: :cascade do |t|
    t.string "name"
    t.text "address"
    t.datetime "open_time"
    t.datetime "close_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reservations", force: :cascade do |t|
    t.datetime "from"
    t.datetime "to"
    t.float "total_amount"
    t.integer "slot_id"
    t.integer "customer_id"
    t.string "plate_number"
    t.datetime "cancelled_at"
    t.float "cancellation_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource"
  end

  create_table "slots", force: :cascade do |t|
    t.string "name"
    t.float "price"
    t.time "open_time"
    t.time "close_time"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "parking_id"
    t.index ["name", "parking_id"], name: "index_slots_on_name_and_parking_id", unique: true
    t.index ["parking_id"], name: "index_slots_on_parking_id"
  end

  create_table "users", force: :cascade do |t|
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

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  add_foreign_key "features", "parkings"
  add_foreign_key "features_slots", "features"
  add_foreign_key "features_slots", "slots"
  add_foreign_key "slots", "parkings"
end
