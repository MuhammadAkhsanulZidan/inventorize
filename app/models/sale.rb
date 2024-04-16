class Sale < ApplicationRecord
    has_many :items, through: :items_sales
    belongs_to :storage
end
