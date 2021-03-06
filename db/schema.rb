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

ActiveRecord::Schema.define(version: 20180818011908) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "kind"
    t.string "fields"
  end

  create_table "field_chains", force: :cascade do |t|
    t.bigint "item_field_id"
    t.bigint "sub_field_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_field_id", "sub_field_id"], name: "index_field_chains_on_item_field_id_and_sub_field_id", unique: true
    t.index ["item_field_id"], name: "index_field_chains_on_item_field_id"
    t.index ["sub_field_id"], name: "index_field_chains_on_sub_field_id"
  end

  create_table "field_groups", force: :cascade do |t|
    t.bigint "category_id"
    t.bigint "item_field_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_field_groups_on_category_id"
    t.index ["item_field_id"], name: "index_field_groups_on_item_field_id"
  end

  create_table "field_values", force: :cascade do |t|
    t.string "name"
    t.bigint "item_field_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.hstore "properties"
    t.index ["item_field_id"], name: "index_field_values_on_item_field_id"
    t.index ["properties"], name: "index_field_values_on_properties", using: :gist
  end

  create_table "item_fields", force: :cascade do |t|
    t.string "field_type"
    t.string "field_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.integer "sku"
    t.hstore "properties"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_items_on_category_id"
  end

  create_table "value_groups", force: :cascade do |t|
    t.bigint "item_id"
    t.bigint "field_value_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["field_value_id"], name: "index_value_groups_on_field_value_id"
    t.index ["item_id"], name: "index_value_groups_on_item_id"
  end

  add_foreign_key "field_values", "item_fields"
  add_foreign_key "value_groups", "field_values"
  add_foreign_key "value_groups", "items"
end
