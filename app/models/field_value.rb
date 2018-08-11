class FieldValue < ApplicationRecord
  belongs_to :item_field, optional: true
  has_many :value_groups, dependent: :destroy
  has_many :items, through: :value_groups

  scope :original, -> {where(name: "original")}
  scope :one_of_a_kind, -> {where(name: "one-of-a-kind")}
  scope :hand_blown_glass, -> {where(name: "hand blown glass")}
  scope :hand_made_ceramic, -> {where(name: "hand made ceramic")}

  def self.default_id(category_name)
    self.public_send(category_name.gsub("-", "_").downcase.split(" ").first).pluck(:id).first
  end

  def self.to_csv(fields = column_names, options = {})
    CSV.generate(options) do |csv|
      csv << fields
      all.each do |field_value|
        csv << field_value.attributes.values_at(*fields)
      end
    end
  end

  def self.import(file)
    spreadsheet = Roo::Spreadsheet.open(file.path)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      field_value = find_by(id: row["id"]) || new
      field_value.attributes = row.to_hash
      field_value.save!
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
end
