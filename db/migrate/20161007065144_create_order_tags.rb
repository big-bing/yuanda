class CreateOrderTags < ActiveRecord::Migration[5.0]
  def change
    create_table :order_tags do |t|
      t.integer :tag_id
      t.integer :order_id
      t.datetime :deleted_at
    end
    add_index :order_tags, :deleted_at
    remove_column :orders, :tag_id
  end
end
