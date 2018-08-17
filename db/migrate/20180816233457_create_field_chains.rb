class CreateFieldChains < ActiveRecord::Migration[5.1]
  def change
    create_table :field_chains do |t|
      t.belongs_to :item_field
      t.belongs_to :sub_field

      t.timestamps
      t.index [:item_field_id, :sub_field_id], unique: true
    end
  end
end
