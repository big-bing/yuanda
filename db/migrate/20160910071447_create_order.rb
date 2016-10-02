class CreateOrder < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :name
      t.text :description
      t.integer :user_id
      t.timestamp
    end
  end
end
