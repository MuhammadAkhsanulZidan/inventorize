class CreateItemSales < ActiveRecord::Migration[7.1]
  def change
    create_table :item_sales do |t|
      t.references :item, null: false, foreign_key: true
      t.references :sale, null: false, foreign_key: true

      t.timestamps
    end
  end
end
