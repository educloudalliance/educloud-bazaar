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

ActiveRecord::Schema.define(version: 20170417140619) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "images", force: :cascade do |t|
    t.string   "url"
    t.string   "type"
    t.integer  "width"
    t.integer  "height"
    t.integer  "material_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["material_id"], name: "index_images_on_material_id", using: :btree
  end

  create_table "material_tags", force: :cascade do |t|
    t.integer  "tag_id",      null: false
    t.integer  "material_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["material_id"], name: "index_material_tags_on_material_id", using: :btree
    t.index ["tag_id"], name: "index_material_tags_on_tag_id", using: :btree
  end

  create_table "materials", force: :cascade do |t|
    t.string   "name",                  limit: 255,              null: false
    t.text     "description",                                    null: false
    t.string   "language",                                       null: false
    t.integer  "publisher_resource_id"
    t.text     "publisher_data"
    t.text     "metadata",                          default: [],              array: true
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
