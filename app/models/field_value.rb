class FieldValue < ApplicationRecord
  belongs_to :item_field, optional: true
end
