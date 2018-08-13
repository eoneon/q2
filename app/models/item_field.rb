class ItemField < ApplicationRecord
  has_many :field_groups, dependent: :destroy
  has_many :categories, through: :field_groups

  has_many :field_values, dependent: :destroy

  def self.to_csv(fields = column_names, options = {})
    CSV.generate(options) do |csv|
      csv << fields
      all.each do |item_field|
        csv << item_field.attributes.values_at(*fields)
      end
    end
  end

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

  def open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Csv.new(file.path, nil, :ignore)
    when ".xls" then Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Excelx.new(file.path, nil, :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

  def self.original_painting
    %w(mounting_type original_kind paint_medium substrate_type canvas_kind paper_kind board_kind signature_kind certificate_kind)
  end

  def self.original_sketch
    %w(mounting_type original_kind sketch_medium substrate_type signature_kind certificate_kind)
  end

  def self.one_of_a_kind_mixed_media
    %w(mounting_type original_kind mixed_medium substrate_type signature_kind certificate_kind)
  end

  #######limited edition
  def self.limited_edition_print
    %w(mounting_type embellish_medium limited_kind print_medium substrate_type edition_type signature_kind certificate_kind)
  end

  def self.limited_edition_print_with_leafing
    %w(mounting_type embellish_medium limited_kind print_medium substrate_type leafing_medium edition_type signature_kind certificate_kind)
  end

  def self.limited_edition_print_with_remarque
    %w(mounting_type embellish_medium limited_kind print_media substrate_type remarque_media edition_type signature_kind certificate_kind)
  end

  def self.limited_edition_print_with_leafing_and_remarque
    %w(mounting_type embellish_media limited_kind print_medium substrate_type leafing_medium remarque_medium edition_type signature_kind certificate_kind)
  end

  #######print
  def self.print
    %w(mounting_type embellish_medium print_medium substrate_type edition_type signature_kind certificate_kind)
  end

  def self.print_with_leafing
    %w(mounting_type embellish_medium print_medium substrate_type leafing_medium edition_type signature_kind certificate_kind)
  end

  def self.print_with_remarque
    %w(mounting_type embellish_medium print_medium substrate_type remarque_medium edition_type signature_kind certificate_kind)
  end

  def self.print_with_leafing_and_remarque
    %w(mounting_type embellish_medium print_medium substrate_type leafing_medium remarque_medium edition_type signature_kind certificate_kind)
  end

  #sculptures
  def self.hand_blown_glass
    %w(handblown_medium sculpture_kind signature_kind certificate_kind)
  end

  def self.hand_made_ceramic
    %w(handmade_medium sculpture_kind signature_kind certificate_kind)
  end

  def self.sculpture
    %w(sculpture_media sculpture_kind signature_kind certificate_kind)
  end

  def self.limited_edition_sculpture
    %w(limited_kind sculpture_medium signature_kind edition_type signature_kind certificate_kind)
  end

  def self.category_name(name)
    public_send(name.gsub("-", "_").downcase.split(" ").join("_"))
  end

  # def self.category_name(name)
  #   public_send(self.format_category_name(name).join("_"))
  # end
  #
  # def self.format_category_name(name)
  #   name.gsub("-", "_").downcase.split(" ")
  # end

  def self.category_fields(name)
    #ItemField.where(field_name: ItemField.category_name(name))
    ItemField.category_name(name).map {|field| ItemField.where(field_name: field)}.flatten
  end
end
