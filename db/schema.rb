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

ActiveRecord::Schema.define(version: 20170627205010) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accruals", force: :cascade do |t|
    t.integer  "coid_id"
    t.string   "provider"
    t.string   "agency"
    t.date     "shift_date"
    t.string   "expense_type"
    t.float    "units"
    t.float    "rate"
    t.float    "accrual"
    t.string   "reference_id"
    t.string   "source"
    t.integer  "month"
    t.integer  "year"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["coid_id"], name: "index_accruals_on_coid_id", using: :btree
  end

  create_table "coids", force: :cascade do |t|
    t.string   "name"
    t.integer  "coid"
    t.string   "division"
    t.string   "market"
    t.string   "group"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coid"], name: "index_coids_on_coid", using: :btree
  end

  create_table "payments", force: :cascade do |t|
    t.integer  "coid_id"
    t.date     "shift_date"
    t.string   "agency"
    t.string   "physician"
    t.float    "units"
    t.float    "bill_rate"
    t.float    "billed_amount"
    t.string   "expense_type"
    t.string   "comments"
    t.string   "reference_id"
    t.date     "bill_date"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["coid_id"], name: "index_payments_on_coid_id", using: :btree
  end

  create_table "providers", force: :cascade do |t|
    t.integer  "coid_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "parallon_name"
    t.boolean  "active",        default: true, null: false
    t.date     "start_date"
    t.date     "end_date"
    t.string   "speciality"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["coid_id"], name: "index_providers_on_coid_id", using: :btree
  end

  create_table "schedules", force: :cascade do |t|
    t.integer  "coid_id"
    t.string   "provider"
    t.string   "agency"
    t.date     "date"
    t.integer  "month"
    t.integer  "year"
    t.float    "units"
    t.string   "uom"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coid_id"], name: "index_schedules_on_coid_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree
  end

end
