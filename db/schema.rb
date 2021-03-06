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

ActiveRecord::Schema.define(version: 20131107103739) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "directions", force: true do |t|
    t.text     "body"
    t.integer  "recipe_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "directions", ["recipe_id"], name: "index_directions_on_recipe_id", using: :btree

  create_table "forks", force: true do |t|
    t.integer  "source_id"
    t.integer  "fork_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "forks", ["fork_id"], name: "index_forks_on_fork_id", using: :btree
  add_index "forks", ["source_id", "fork_id"], name: "index_forks_on_source_id_and_fork_id", unique: true, using: :btree
  add_index "forks", ["source_id"], name: "index_forks_on_source_id", using: :btree

  create_table "ingredients", force: true do |t|
    t.string   "food"
    t.string   "units"
    t.integer  "recipe_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "count",      precision: 6, scale: 2
  end

  add_index "ingredients", ["recipe_id"], name: "index_ingredients_on_recipe_id", using: :btree

  create_table "recipes", force: true do |t|
    t.string   "title"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "stars_count", default: 0
    t.integer  "forks_count", default: 0
  end

  add_index "recipes", ["title"], name: "index_recipes_on_title", using: :btree
  add_index "recipes", ["user_id"], name: "index_recipes_on_user_id", using: :btree

  create_table "stars", force: true do |t|
    t.integer  "recipe_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "stars", ["recipe_id", "user_id"], name: "index_stars_on_recipe_id_and_user_id", unique: true, using: :btree
  add_index "stars", ["recipe_id"], name: "index_stars_on_recipe_id", using: :btree
  add_index "stars", ["user_id"], name: "index_stars_on_user_id", using: :btree

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "recipe_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "taggings", ["recipe_id"], name: "index_taggings_on_recipe_id", using: :btree
  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree

  create_table "tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["name"], name: "index_tags_on_name", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.integer  "stars_count",            default: 0
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
