class Item < ApplicationRecord
  belongs_to :storage
  has_many :sales, through: :items_sales
end
