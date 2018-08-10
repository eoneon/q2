class Category < ApplicationRecord
  has_many :field_groups, dependent: :destroy
  has_many :item_fields, through: :field_groups
  has_many :items

  accepts_nested_attributes_for :field_groups, reject_if: proc {|attrs| attrs['item_field_id'].blank?}, allow_destroy: true

  def self.category_dropdown
    ["Original Painting", "One-of-a-Kind Mixed-Media", "Original Sketch", "Limited Edition Print", "Limited Edition Print with Leafing", "Limited Edition Print with Remarque", "Limited Edition Print with Leafing and Remarque", "Print", "Print with Leafing", "Print with Remarque", "Print with Leafing and Remarque", "Hand-Blown Glass", "Hand-Made Ceramic", "Limited Edition Sculpture", "Sculpture"]
  end
end
