class ChangeOrdersTable < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :tel, :string
    add_column :orders, :handling_amout, :float
    add_column :orders, :handling_description, :text
    add_column :orders, :make_time, :integer
    add_column :orders, :tag_id, :integer
  end
end
