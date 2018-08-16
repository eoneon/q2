class FieldValue < ApplicationRecord
  include Importable
  
  belongs_to :item_field, optional: true
  has_many :value_groups, dependent: :destroy
  has_many :items, through: :value_groups

  scope :original, -> {where(name: "original")}
  scope :one_of_a_kind, -> {where(name: "one-of-a-kind")}
  scope :hand_blown_glass, -> {where(name: "hand blown glass")}
  scope :hand_made_ceramic, -> {where(name: "hand made ceramic")}

  def self.field_keys
    %w(parent title body both attribute)
  end

  def self.default_id(category_name)
    self.public_send(category_name.gsub("-", "_").downcase.split(" ").first).pluck(:id).first
  end
end
