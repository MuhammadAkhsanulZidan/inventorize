class CreateUsersStorages < ActiveRecord::Migration[7.1]
  def change
    create_table :users_storages do |t|
      t.references :user, null: false, foreign_key: true
      t.references :storage, null: false, foreign_key: true
      t.integer :role

      #t.timestamps
    end
  end
end
