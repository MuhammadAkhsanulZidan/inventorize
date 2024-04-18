class Item < ApplicationRecord
  belongs_to :storage
  has_many :sales, through: :item_sales
end
