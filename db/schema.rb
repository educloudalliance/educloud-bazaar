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

ActiveRecord::Schema.define(version: 20170613121948) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cms_sessions", force: :cascade do |t|
    t.string  "first_name",                null: false
    t.string  "last_name",                 null: false
    t.string  "email"
    t.string  "user_id",                   null: false
    t.string  "context_id",                null: false
    t.integer "role",                      null: false
    t.string  "school",                    null: false
    t.string  "school_id",                 null: false
    t.string  "city",                      null: false
    t.string  "city_id",                   null: false
    t.string  "oid"
    t.string  "add_resource_callback_url"
    t.string  "cancel_url"
    t.string  "uid",                       null: false
    t.index ["uid"], name: "index_cms_sessions_on_uid", unique: true, using: :btree
  end

  create_table "materials", force: :cascade do |t|
    t.string   "name",                  limit: 255, null: false
    t.text     "description",                       null: false
    t.string   "language",                          null: false
    t.integer  "publisher_resource_id"
    t.text     "publisher_data"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "materials_metadata", force: :cascade do |t|
    t.integer  "metadata_id"
    t.integer  "material_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["material_id"], name: "index_materials_metadata_on_material_id", using: :btree
    t.index ["metadata_id"], name: "index_materials_metadata_on_metadata_id", using: :btree
  end

  create_table "metadata", force: :cascade do |t|
    t.string   "country"
    t.string   "subject"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.boolean  "enabled",    default: true
  end

  create_table "shopping_cart_items", force: :cascade do |t|
    t.integer  "owner_id"
    t.string   "owner_type"
    t.integer  "quantity"
    t.integer  "item_id"
    t.string   "item_type"
    t.integer  "price_cents",    default: 0,     null: false
    t.string   "price_currency", default: "USD", null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "shopping_carts", force: :cascade do |t|
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "cms_sessions_id"
    t.index ["cms_sessions_id"], name: "index_shopping_carts_on_cms_sessions_id", using: :btree
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.string   "taggable_type"
    t.integer  "taggable_id"
    t.string   "tagger_type"
    t.integer  "tagger_id"
    t.string   "context",       limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context", using: :btree
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
    t.index ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy", using: :btree
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id", using: :btree
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type", using: :btree
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type", using: :btree
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true, using: :btree
  end

  create_table "tokens", force: :cascade do |t|
    t.string   "client_id"
    t.string   "secret_key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_tokens_on_client_id", using: :btree
    t.index ["secret_key"], name: "index_tokens_on_secret_key", using: :btree
  end

end
