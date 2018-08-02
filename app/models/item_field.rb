class ItemField < ApplicationRecord
  belongs_to :category, optional: true
  has_many :field_values, dependent: :destroy
end
