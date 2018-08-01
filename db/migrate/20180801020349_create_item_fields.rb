class CreateItemFields < ActiveRecord::Migration[5.1]
  def change
    create_table :item_fields do |t|
      t.string :field_type
      t.string :field_name
      t.references :category, foreign_key: true, index: true

      t.timestamps
    end
  end
end
