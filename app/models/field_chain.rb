class FieldChain < ApplicationRecord
  belongs_to :item_field 
  belongs_to :sub_field, optional: true, class_name: 'ItemField'
end
