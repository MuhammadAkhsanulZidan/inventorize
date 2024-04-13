class UsersStorage < ApplicationRecord
  belongs_to :user
  belongs_to :storage
end
