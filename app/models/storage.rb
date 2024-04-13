class Storage < ApplicationRecord
    has_many :users_storages, dependent: :destroy
    has_many :users, through: :users_storages
    has_many :items
end
