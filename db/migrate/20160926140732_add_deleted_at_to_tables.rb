class AddDeletedAtToTables < ActiveRecord::Migration
  def change
    add_column :orders, :deleted_at, :datetime
    add_index :orders, :deleted_at
    add_column :items, :deleted_at, :boolean
    add_index :items, :deleted_at
  end
end
