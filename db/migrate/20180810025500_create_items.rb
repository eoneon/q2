class CreateItems < ActiveRecord::Migration[5.1]
  def change
    enable_extension 'hstore' unless extension_enabled?('hstore')
    create_table :items do |t|
      t.integer :sku
      t.hstore :properties
      t.references :category, index: true

      t.timestamps
    end
  end
end
