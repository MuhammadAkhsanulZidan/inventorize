class CreateSales < ActiveRecord::Migration[7.1]
  def change
    create_table :sales do |t|
      t.references :storage, null: false, foreign_key: true
      t.datetime :transaction_date
      
      t.timestamps
    end
  end
end
