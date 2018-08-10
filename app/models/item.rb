class Item < ApplicationRecord
  belongs_to :category, optional: true
  has_many :value_groups, dependent: :destroy
  has_many :field_values, through: :value_groups
  
  accepts_nested_attributes_for :value_groups, reject_if: proc {|attrs| attrs['field_value_id'].blank?}, allow_destroy: true
end
