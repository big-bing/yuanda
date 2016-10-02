class AddPunchToItems < ActiveRecord::Migration
  def change
    add_column :items, :punch_count, :integer
    add_column :items, :punch_price, :float
    add_column :items, :dig_angle_count, :integer
    add_column :items, :dig_angle_price, :float
  end
end
