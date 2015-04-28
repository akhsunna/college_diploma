# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150428074300) do

  create_table "group_subjects", id: false, force: :cascade do |t|
    t.integer "group_id",   limit: 4, null: false
    t.integer "subject_id", limit: 4, null: false
  end

  add_index "group_subjects", ["group_id"], name: "fk_rails_bbfe43ba26", using: :btree
  add_index "group_subjects", ["subject_id"], name: "fk_rails_0e7377d240", using: :btree

  create_table "groups", force: :cascade do |t|
    t.string   "name",          limit: 255, null: false
    t.integer  "course",        limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "speciality_id", limit: 4
  end

  add_index "groups", ["speciality_id"], name: "index_groups_on_speciality_id", using: :btree

  create_table "items", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id",  limit: 4
    t.integer  "subject_id", limit: 4
  end

  add_index "items", ["subject_id"], name: "index_items_on_subject_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string "name", limit: 255, null: false
  end

  create_table "specialities", force: :cascade do |t|
    t.string   "short_name", limit: 255, null: false
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subjects", force: :cascade do |t|
    t.string   "short_name", limit: 255
    t.string   "name",       limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",    limit: 4
    t.integer  "root_id",    limit: 4
  end

  add_index "subjects", ["user_id"], name: "index_subjects_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                   limit: 255
    t.string   "full_name",              limit: 255
    t.integer  "group_id",               limit: 4
    t.integer  "role_id",                limit: 4
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["group_id"], name: "index_users_on_group_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["role_id"], name: "index_users_on_role_id", using: :btree

  add_foreign_key "group_subjects", "groups"
  add_foreign_key "group_subjects", "subjects"
  add_foreign_key "groups", "specialities"
  add_foreign_key "items", "subjects"
  add_foreign_key "subjects", "users"
  add_foreign_key "users", "groups"
  add_foreign_key "users", "roles"
end
