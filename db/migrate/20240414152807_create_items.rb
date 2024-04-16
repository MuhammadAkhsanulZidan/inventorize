class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.references :storage, null: false, foreign_key: true
      t.string :image
      t.integer :quantity, null: false
      t.integer :unit, null: false
      t.string :description
      t.integer :cost_price 
      t.integer :sell_price

      t.timestamps
    end
  end
end
