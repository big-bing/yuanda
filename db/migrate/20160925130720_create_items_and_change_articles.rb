class CreateItemsAndChangeArticles < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.integer :width
      t.integer :height
      t.integer :number
      t.float :size
      t.integer :price
      t.float :amout

      t.timestamp
    end

    rename_column :orders, :description, :code
    add_column :orders, :number, :integer
    add_column :orders, :size, :float
    add_column :orders, :amout, :float
    add_column :orders, :total_amout, :integer
    add_column :orders, :capital_total_amout, :string
    add_column :orders, :prepaid_amout, :integer
    add_column :orders, :rest_amout, :integer
  end
end
