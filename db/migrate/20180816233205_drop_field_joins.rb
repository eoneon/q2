class DropFieldJoins < ActiveRecord::Migration[5.1]
  def change
    drop_table :field_joins
  end
end
