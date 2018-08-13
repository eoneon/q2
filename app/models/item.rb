class Item < ApplicationRecord
  belongs_to :category, optional: true
  has_many :value_groups, dependent: :destroy
  has_many :field_values, through: :value_groups

  accepts_nested_attributes_for :value_groups, reject_if: proc {|attrs| attrs['field_value_id'].blank?}, allow_destroy: true

  def field_value_names
    field_values.pluck(:name)
  end
  #mounting_type, substrate_type, edition_type => id
  def self.parent_id(field_name)
    ItemField.where(field_name: field_name).pluck(:id)[0]
  end
  #parent_id => [canvas, paper, board], [framed, wrapped, border], [numbered_xy, numbered_qty, from_an_edition, roman_numbered]
  def self.child_values(id)
    FieldValue.where(item_field_id: id).pluck(:name)
  end

  #combines top-2: [canvas, paper, board], [framed, wrapped, border], [numbered_xy, numbered_qty, from_an_edition, roman_numbered]
  def self.type_values(field_name)
    Item.child_values(Item.parent_id(field_name))
  end

  def parent_type_value(field_name)
    field_value_names & Item.type_values(field_name)
  end

  def category_fields
    fields = category.fields_arr
    %w(mounting_type substrate_type edition_type).each do |type_field|
      if parent_type_value(type_field)[0]
        idx = fields.index(type_field) + 1
        fields.insert(idx, Item.type_values(type_field))
      end
    end
    fields.flatten.map {|field_name| ItemField.where(field_name: field_name)}.flatten
  end

  def selected_field_value(item_field)
    field_value_ids & item_field.field_value_ids
  end
end
