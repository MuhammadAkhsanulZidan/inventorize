class CreateItemSales < ActiveRecord::Migration[7.1]
  def change
    create_table :item_sales do |t|
      t.references :item, null: false, foreign_key: true
      t.references :sale, null: false, foreign_key: true
      t.integer :quantity
      t.integer :discount_val
      t.integer :discount_unit
      t.integer :amount

      t.timestamps
    end
  end
end
