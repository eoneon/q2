class AddPropertiesToFieldValues < ActiveRecord::Migration[5.1]
  def change
    enable_extension 'hstore' unless extension_enabled?('hstore')
    add_column :field_values, :properties, :hstore

    add_index :field_values, :properties, using: :gist
  end
end
