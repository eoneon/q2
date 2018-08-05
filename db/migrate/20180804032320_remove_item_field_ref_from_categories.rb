class RemoveItemFieldRefFromCategories < ActiveRecord::Migration[5.1]
  def change
    remove_reference :item_fields, :category, index: true, foreign_key: true
  end
end
