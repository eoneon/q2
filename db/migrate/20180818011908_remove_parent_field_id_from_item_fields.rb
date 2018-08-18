class RemoveParentFieldIdFromItemFields < ActiveRecord::Migration[5.1]
  def change
    remove_column :item_fields, :parent_field_id
  end
end
