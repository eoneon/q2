class Category < ApplicationRecord
  has_many :item_fields, dependent: :destroy
end
