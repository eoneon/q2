class CreateFieldGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :field_groups do |t|
      t.references :categories, index: true
      t.references :item_fields, index: true

      t.timestamps
    end
  end
end
