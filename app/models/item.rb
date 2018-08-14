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

  def mounting_type
    h = {"framed" => "frame_kind frame_width frame_height", "wrapped" => "wrapped_kind", "border" =>"border_kind border_width border_height"}
  end

  def substrate_type
    h = {"canvas" => "canvas_kind image_width image_height", "paper" => "paper_kind image_width image_height", "board" => "board_kind image_width image_height"}
  end

  def edition_type
    h = {"numbered_xy" => "edition_kind edition_number edition_size", "from_an_edition" => "edition_kind", "roman_numbered" => "edition_kind roman_number roman_size"}
  end

  def category_fields
    fields = category.fields_arr
    %w(mounting_type substrate_type edition_type).each do |type_field|
      if parent_type_value(type_field)[0].present? && parent_type_value(type_field)[0] != "numbered_qty"
        idx = fields.index(type_field) + 1
        new_fields = public_send(type_field)[parent_type_value(type_field)[0]].squish.split(" ")
        fields.insert(idx, new_fields)
      end
    end
    fields.flatten.map {|field_name| ItemField.where(field_name: field_name)}.flatten
    #fields.flatten
  end

  def selected_field_value(item_field)
    field_value_ids & item_field.field_value_ids
  end

  def wtf
    ItemField.where(field_name: "edition_number")
  end
end
