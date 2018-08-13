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
  #parent_id => canvas, paper, board, framed, wrapped, border, numbered_xy, numbered_qty, from_an_edition, roman_numbered
  def self.child_values(id)
    FieldValue.where(item_field_id: id).pluck(:name)
  end

  def parent_type_value(field_name)
    field_value_names & Item.child_values(Item.parent_id(field_name))
  end
end
