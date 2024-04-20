class CreateSales < ActiveRecord::Migration[7.1]
  def change
    create_table :sales do |t|
      t.date :transaction_date
      t.text :note
      t.integer :shipping_charge
      t.integer :total_amount
      t.references :storage, null: false, foreign_key: true

      t.timestamps
    end
  end
end
