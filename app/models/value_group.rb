class ValueGroup < ApplicationRecord
  belongs_to :item
  belongs_to :field_value
end
