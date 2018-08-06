class ItemField < ApplicationRecord
  has_many :field_groups, dependent: :destroy
  has_many :categories, through: :field_groups

  has_many :field_values, dependent: :destroy

  def self.import(file)
    spreadsheet = Roo::Spreadsheet.open(file.path)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      item_field = find_by(id: row["id"]) || new
      item_field.attributes = row.to_hash
      item_field.save!
    end
  end

  def self.original_painting
    %w(flat_mounting original_kind paint_medium substrate_type signature_kind certificate_kind)
  end

  def original_sketch
    %w(flat_mounting original_kind sketch_medium substrate_type signature_kind certificate_kind)
  end

  def one_of_a_kind_mixed_media
    %w(flat_mounting original_kind mixed_medium substrate_type signature_kind certificate_kind)
  end

  #######limited edition
  def limited_edition_print
    %w(flat_mounting embellish_medium limited_kind print_medium substrate_type edition_type signature_kind certificate_kind)
  end

  def limited_edition_print_with_leafing
    %w(flat_mounting embellish_medium limited_kind print_medium substrate_type leafing_medium edition_type signature_kind certificate_kind)
  end

  def limited_edition_print_with_remarque
    %w(flat_mounting embellish_medium limited_kind print_media substrate_type remarque_media edition_type signature_kind certificate_kind)
  end

  def limited_edition_print_with_leafing_and_remarque
    %w(flat_mounting embellish_media limited_kind print_medium substrate_type leafing_medium remarque_medium edition_type signature_kind certificate_kind)
  end

  #######print
  def print
    %w(flat_mounting embellish_medium print_medium substrate_type edition_type signature_kind certificate_kind)
  end

  def print_with_leafing
    %w(flat_mounting embellish_medium print_medium substrate_type leafing_medium edition_type signature_kind certificate_kind)
  end

  def print_with_remarque
    %w(flat_mounting embellish_medium print_medium substrate_type remarque_medium edition_type signature_kind certificate_kind)
  end

  def print_with_leafing_and_remarque
    %w(flat_mounting embellish_medium print_medium substrate_type leafing_medium remarque_medium edition_type signature_kind certificate_kind)
  end

  #sculptures
  def hand_blown_glass
    %w(handblown_medium sculpture_kind signature_kind certificate_kind)
  end

  def hand_made_ceramic
    %w(handmade_medium sculpture_kind signature_kind certificate_kind)
  end

  def sculpture
    %w(sculpture_media sculpture_kind signature_kind certificate_kind)
  end

  def limited_edition_sculpture
    %w(limited_kind sculpture_medium signature_kind edition_type signature_kind certificate_kind)
  end

  def self.category_name(name)
    public_send(name.gsub("-", "_").downcase.split(" ").join("_"))
  end

  def self.category_fields(name)
    #ItemField.category_name(name).map {|field_group| ItemField.where(name: public_send(field_group))}
    ItemField.where(field_name: ItemField.category_name(name))
  end
end
