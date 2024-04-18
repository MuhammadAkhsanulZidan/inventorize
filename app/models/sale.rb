class Sale < ApplicationRecord
  has_many :items, through: :item_sales
  belongs_to :storage
end
