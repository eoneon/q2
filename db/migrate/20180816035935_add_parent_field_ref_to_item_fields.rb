class AddParentFieldRefToItemFields < ActiveRecord::Migration[5.1]
  def change
    add_reference :item_fields, :parent_field, index: true
  end
end
