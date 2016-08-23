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

ActiveRecord::Schema.define(version: 20160208041916) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "memberships", force: :cascade do |t|
    t.integer  "repo_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["repo_id"], name: "index_memberships_on_repo_id", using: :btree
    t.index ["user_id"], name: "index_memberships_on_user_id", using: :btree
  end

  create_table "repos", force: :cascade do |t|
    t.integer "github_id",                        null: false
    t.boolean "active",           default: false, null: false
    t.string  "full_github_name",                 null: false
    t.integer "hook_id"
    t.index ["github_id"], name: "index_repos_on_github_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider"
    t.string   "email"
    t.string   "name"
    t.string   "token"
    t.string   "token_scopes",                 array: true
    t.string   "github_username"
    t.integer  "github_uid",      null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["github_uid"], name: "index_users_on_github_uid", using: :btree
    t.index ["token_scopes"], name: "index_users_on_token_scopes", using: :gin
  end

  add_foreign_key "memberships", "repos"
  add_foreign_key "memberships", "users"
end
