class FieldChain < ApplicationRecord
  belongs_to :item_field, optional: true
  belongs_to :sub_field, optional: true, class_name: 'ItemField'
end
