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

ActiveRecord::Schema.define(version: 2018_07_12_201109) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "account_name"
    t.string "email"
    t.string "phone"
    t.string "business_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "emails", force: :cascade do |t|
    t.text "subject"
    t.bigint "profile_id"
    t.datetime "mail_initiate_time"
    t.boolean "starred"
    t.boolean "important"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mail_messages", force: :cascade do |t|
    t.bigint "email_unique_id"
    t.text "message_content"
    t.string "sender"
    t.string "recipient"
    t.string "cc"
    t.string "bcc"
    t.text "attachment_urls"
    t.datetime "message_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.string "email"
    t.string "encrypted_password"
    t.string "provider"
    t.bigint "account_id"
    t.bigint "fetch_interval"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "encrypted_password"
    t.string "salt"
    t.string "user_type"
    t.bigint "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
