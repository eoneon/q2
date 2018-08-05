class ItemField < ApplicationRecord
  has_many :field_groups, dependent: :destroy
  has_many :categories, through: :field_groups
  
  has_many :field_values, dependent: :destroy
end
