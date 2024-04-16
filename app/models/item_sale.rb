class ItemSale < ApplicationRecord
  belongs_to :item
  belongs_to :sale
end
