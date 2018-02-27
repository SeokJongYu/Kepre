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

ActiveRecord::Schema.define(version: 20180226234503) do

  create_table "analyses", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "job_id"
    t.string "status"
    t.integer "datum_id"
    t.integer "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["datum_id"], name: "index_analyses_on_datum_id"
    t.index ["project_id"], name: "index_analyses_on_project_id"
  end

  create_table "bcell_antibody_items", force: :cascade do |t|
    t.string "name"
    t.string "swiss"
    t.integer "datum_id"
    t.string "prediction_method"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["datum_id"], name: "index_bcell_antibody_items_on_datum_id"
  end

  create_table "class_immu_items", force: :cascade do |t|
    t.string "name"
    t.integer "datum_id"
    t.string "position_mask"
    t.string "alleles"
    t.string "custom_val"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["datum_id"], name: "index_class_immu_items_on_datum_id"
  end

  create_table "dashboards", force: :cascade do |t|
    t.integer "project_count"
    t.integer "analysis_count"
    t.integer "execution_time"
    t.decimal "avg_time"
    t.integer "total_data"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_dashboards_on_user_id"
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

  create_table "disco_tope_items", force: :cascade do |t|
    t.string "name"
    t.string "pdb"
    t.string "chain"
    t.string "version"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ellipro_items", force: :cascade do |t|
    t.string "name"
    t.string "pdb"
    t.string "min"
    t.string "max"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "kbio_mhci_items", force: :cascade do |t|
    t.string "name"
    t.integer "datum_id"
    t.integer "percentile_rank"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["datum_id"], name: "index_kbio_mhci_items_on_datum_id"
  end

  create_table "kbio_mhci_results", force: :cascade do |t|
    t.integer "seq_id"
    t.string "aa"
    t.string "allele"
    t.decimal "score", precision: 10, scale: 5
    t.integer "result_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["result_id"], name: "index_kbio_mhci_results_on_result_id"
  end

  create_table "kbio_mhcii_items", force: :cascade do |t|
    t.string "name"
    t.integer "datum_id"
    t.integer "percentile_rank"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["datum_id"], name: "index_kbio_mhcii_items_on_datum_id"
  end

  create_table "kbio_mhcii_results", force: :cascade do |t|
    t.integer "seq_id"
    t.string "aa"
    t.string "allele"
    t.decimal "score"
    t.integer "result_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["result_id"], name: "index_kbio_mhcii_results_on_result_id"
  end

  create_table "mhci_items", force: :cascade do |t|
    t.string "name"
    t.integer "datum_id"
    t.string "prediction_method"
    t.string "species"
    t.string "alleles"
    t.integer "length"
    t.string "output_sort"
    t.string "output_format"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["datum_id"], name: "index_mhci_items_on_datum_id"
  end

  create_table "mhci_results", force: :cascade do |t|
    t.string "allele"
    t.integer "seq_num"
    t.integer "start"
    t.integer "end"
    t.integer "length"
    t.string "peptide"
    t.string "method"
    t.decimal "percentile_rank", precision: 10, scale: 5
    t.decimal "ann_ic50", precision: 10, scale: 5
    t.decimal "ann_rank", precision: 10, scale: 5
    t.decimal "smm_ic50", precision: 10, scale: 5
    t.decimal "smm_rank", precision: 10, scale: 5
    t.decimal "comblib_sidney2008_score", precision: 10, scale: 5
    t.decimal "comblib_sidney2008_rank", precision: 10, scale: 5
    t.decimal "netmhcpan_ic50", precision: 10, scale: 5
    t.decimal "netmhcpan_rank", precision: 10, scale: 5
    t.integer "result_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["result_id"], name: "index_mhci_results_on_result_id"
  end

  create_table "mhcii_items", force: :cascade do |t|
    t.string "name"
    t.integer "datum_id"
    t.string "prediction_method"
    t.string "species"
    t.string "alleles"
    t.integer "length"
    t.string "output_sort"
    t.string "output_format"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["datum_id"], name: "index_mhcii_items_on_datum_id"
  end

  create_table "mhcii_results", force: :cascade do |t|
    t.string "allele"
    t.integer "seq_num"
    t.integer "start"
    t.integer "end"
    t.string "peptide"
    t.string "method"
    t.decimal "consensus_percentile_rank", precision: 10, scale: 5
    t.string "comblib_core"
    t.decimal "comblib_score", precision: 10, scale: 5
    t.decimal "comblib_rank", precision: 10, scale: 5
    t.string "smm_align_core"
    t.decimal "smm_align_ic50", precision: 10, scale: 5
    t.decimal "smm_align_rank", precision: 10, scale: 5
    t.string "nn_align_core"
    t.decimal "nn_align_ic50", precision: 10, scale: 5
    t.decimal "nn_align_rank", precision: 10, scale: 5
    t.string "sturniolo_core"
    t.decimal "sturniolo_score", precision: 10, scale: 5
    t.decimal "sturniolo_rank", precision: 10, scale: 5
    t.integer "result_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["result_id"], name: "index_mhcii_results_on_result_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["slug"], name: "index_projects_on_slug", unique: true
  end

  create_table "results", force: :cascade do |t|
    t.string "location"
    t.binary "output"
    t.integer "analysis_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "score"
    t.string "output2"
    t.index ["analysis_id"], name: "index_results_on_analysis_id"
  end

  create_table "tool_items", force: :cascade do |t|
    t.integer "analysis_id"
    t.string "itemable_type"
    t.integer "itemable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["analysis_id"], name: "index_tool_items_on_analysis_id"
    t.index ["itemable_type", "itemable_id"], name: "index_tool_items_on_itemable_type_and_itemable_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

end
