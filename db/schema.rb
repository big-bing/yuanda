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

ActiveRecord::Schema.define(version: 20160929124130) do

  create_table "items", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "name"
    t.integer "width"
    t.integer "height"
    t.integer "number"
    t.float   "size",            limit: 24
    t.integer "price"
    t.float   "amout",           limit: 24
    t.integer "order_id"
    t.boolean "deleted_at"
    t.integer "punch_count"
    t.float   "punch_price",     limit: 24
    t.integer "dig_angle_count"
    t.float   "dig_angle_price", limit: 24
    t.index ["deleted_at"], name: "index_items_on_deleted_at", using: :btree
  end

  create_table "orders", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.text     "code",                limit: 65535
    t.integer  "user_id"
    t.integer  "number"
    t.float    "size",                limit: 24
    t.float    "amout",               limit: 24
    t.integer  "total_amout"
    t.string   "capital_total_amout"
    t.integer  "prepaid_amout"
    t.integer  "rest_amout"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_orders_on_deleted_at", using: :btree
  end

  create_table "versions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string   "item_type",  limit: 191,        null: false
    t.integer  "item_id",                       null: false
    t.string   "event",                         null: false
    t.string   "whodunnit"
    t.text     "object",     limit: 4294967295
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree
  end

end
