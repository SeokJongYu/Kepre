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

ActiveRecord::Schema.define(version: 20180115162816) do

  create_table "analyses", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.integer "data_id"
    t.integer "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["data_id"], name: "index_analyses_on_data_id"
    t.index ["project_id"], name: "index_analyses_on_project_id"
  end

  create_table "data", force: :cascade do |t|
    t.string "name"
    t.text "content"
    t.string "data_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "project_id"
    t.index ["project_id"], name: "index_data_on_project_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "mhci_items", force: :cascade do |t|
    t.string "name"
    t.integer "data_id"
    t.string "prediction_method"
    t.string "species"
    t.string "alleles"
    t.string "output_sort"
    t.string "output_format"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["data_id"], name: "index_mhci_items_on_data_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_projects_on_slug", unique: true
  end

  create_table "results", force: :cascade do |t|
    t.text "output"
    t.integer "analysis_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["analysis_id"], name: "index_results_on_analysis_id"
  end

  create_table "tool_items", force: :cascade do |t|
    t.integer "anlysis_id"
    t.string "itemable_type"
    t.integer "itemable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["anlysis_id"], name: "index_tool_items_on_anlysis_id"
    t.index ["itemable_type", "itemable_id"], name: "index_tool_items_on_itemable_type_and_itemable_id"
  end

end
