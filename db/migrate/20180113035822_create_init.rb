class CreateInit < ActiveRecord::Migration[5.1]
  def change
    create_table "items", force: :cascade do |t|
      t.string   "name"
      t.integer  "width"
      t.integer  "height"
      t.integer  "number"
      t.float    "size",            limit: 24
      t.integer  "price"
      t.float    "amout",           limit: 24
      t.integer  "order_id"
      t.integer  "punch_count"
      t.float    "punch_price",     limit: 24
      t.integer  "dig_angle_count"
      t.float    "dig_angle_price", limit: 24

      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    create_table "order_tags", force: :cascade do |t|
      t.integer  "tag_id"
      t.integer  "order_id"

      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    create_table "orders", force: :cascade do |t|
      t.string   "name"
      t.text     "code",                 limit: 65535
      t.integer  "user_id"
      t.integer  "number"
      t.float    "size",                 limit: 24
      t.float    "amout",                limit: 24
      t.integer  "total_amout"
      t.string   "capital_total_amout"
      t.integer  "prepaid_amout"
      t.integer  "rest_amout"
      t.string   "tel"
      t.float    "handling_amout",       limit: 24
      t.text     "handling_description", limit: 65535
      t.integer  "make_time"
      t.string   "maker_name"

      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    create_table "tags", force: :cascade do |t|
      t.string   "name"
      t.text     "description", limit: 65535
      t.integer  "number"

      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    # create_table "versions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    #   t.string   "item_type",  limit: 191,        null: false
    #   t.integer  "item_id",                       null: false
    #   t.string   "event",                         null: false
    #   t.string   "whodunnit"
    #   t.text     "object",     limit: 4294967295
    #   t.datetime "created_at"
    #   t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree
    # end
  end
end
