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

ActiveRecord::Schema.define(version: 20171120011052) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.boolean  "admin",                  default: false, null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_admins_on_deleted_at", using: :btree
    t.index ["email"], name: "index_admins_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree
  end

  create_table "invites", force: :cascade do |t|
    t.string   "code"
    t.string   "email"
    t.integer  "organization_id"
    t.string   "subdomain"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "unit_id"
    t.datetime "redeemed_at"
    t.integer  "redeemed_by_user_id"
    t.string   "role",                default: "member"
    t.datetime "expires_at"
    t.datetime "deleted_at"
    t.integer  "created_by_user_id"
    t.index ["code"], name: "index_invites_on_code", unique: true, using: :btree
    t.index ["deleted_at"], name: "index_invites_on_deleted_at", using: :btree
    t.index ["email"], name: "index_invites_on_email", using: :btree
  end

  create_table "organizations", force: :cascade do |t|
    t.string   "name"
    t.integer  "size"
    t.string   "sector"
    t.string   "subdomain"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.datetime "deleted_at"
    t.string   "onboarding_steps", default: [],              array: true
    t.index ["deleted_at"], name: "index_organizations_on_deleted_at", using: :btree
  end

  create_table "units", force: :cascade do |t|
    t.string   "name"
    t.integer  "size"
    t.string   "city"
    t.integer  "organization_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.datetime "deleted_at"
    t.string   "onboarding_steps",   default: [],              array: true
    t.string   "state"
    t.integer  "created_by_user_id"
    t.string   "slug"
    t.index ["deleted_at"], name: "index_units_on_deleted_at", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",       null: false
    t.string   "encrypted_password",     default: "",       null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,        null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.string   "role",                   default: "member"
    t.integer  "organization_id"
    t.string   "subdomain"
    t.integer  "unit_id"
    t.datetime "deleted_at"
    t.string   "progress"
    t.string   "phone"
    t.string   "employee_type"
    t.boolean  "scheduled",              default: false
    t.integer  "wage"
    t.string   "slug"
    t.index ["deleted_at"], name: "index_users_on_deleted_at", using: :btree
    t.index ["email", "subdomain"], name: "index_users_on_email_and_subdomain", unique: true, using: :btree
    t.index ["progress"], name: "index_users_on_progress", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
