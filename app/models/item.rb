class Item < ApplicationRecord
  belongs_to :category, optional: true
  has_many :value_groups, dependent: :destroy
  has_many :field_values, through: :value_groups

  accepts_nested_attributes_for :value_groups, reject_if: proc {|attrs| attrs['field_value_id'].blank?}, allow_destroy: true

  def substrate_type
    %w(canvas paper board) & field_values.pluck(:name)
  end

  def mounting_type
    %w(framed wrapped border) & field_values.pluck(:name)
  end

  def edition_type
    %w(numbered_qty numbered_xy from_an_edition roman_numbered) & field_values.pluck(:name)
  end
end
