class ChangeRefNamesForFieldGroups < ActiveRecord::Migration[5.1]
  def change
    rename_column :field_groups, :categories_id, :category_id
    rename_column :field_groups, :item_fields_id, :item_field_id
  end
end
