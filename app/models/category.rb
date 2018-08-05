class Category < ApplicationRecord
  has_many :field_groups, dependent: :destroy
  has_many :item_fields, through: :field_groups

  accepts_nested_attributes_for :field_groups, reject_if: proc {|attrs| attrs['item_field_id'].blank?}, allow_destroy: true
end
