class CreateTags < ActiveRecord::Migration[5.0]
  def change
    create_table :tags do |t|
      t.string :name
      t.text :description
      t.integer :number
      t.datetime :deleted_at

      t.timestamp
    end
    add_index :tags, :deleted_at
  end
end
