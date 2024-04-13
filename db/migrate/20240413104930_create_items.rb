class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.references :storage, null: false, foreign_key: true
      t.string :name
      t.integer :quantity
      t.integer :price

      t.timestamps
    end
  end
end
