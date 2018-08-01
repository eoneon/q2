class CreateElements < ActiveRecord::Migration[5.1]
  def change
    create_table :elements do |t|
      t.references :category, index: true
      t.string :field_name
      t.string :field_type

      t.timestamps
    end
  end
end
